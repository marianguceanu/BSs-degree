using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PartnersAPI.DataContext;
using PartnersAPI.Models;
using PartnersAPI.Models.DTO;
using PartnersAPI.Repository.Interfaces;

namespace PartnersAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class CredentialsController : ControllerBase
    {
        private readonly ICredentialsRepository _credentialsRepo;
        private readonly IPartnersRepository _partnersRepo;
        public CredentialsController(ICredentialsRepository credentialsRepository, IPartnersRepository partnerRepository)
        {
            _credentialsRepo = credentialsRepository;
            _partnersRepo = partnerRepository;
        }

        [HttpGet("all")]
        public async Task<IActionResult> Get()
        {
            var credentials = await _credentialsRepo.GetAll();
            if (credentials == null)
            {
                return NotFound();
            }
            return Ok(credentials);
        }

        [HttpGet("byPersonId/{personId}")]
        public async Task<IActionResult> Get([FromRoute] int personId)
        {
            var credential = await _credentialsRepo.GetCredentialsByPersonId(personId);
            if (credential == null)
            {
                return NotFound();
            }
            return Ok(credential);
        }

        [HttpPost]
        public async Task<IActionResult> Post([FromBody] CredentialsPostPutDTO credential)
        {
            var partner = await _partnersRepo.GetById(credential.PartnerId);
            if (partner == null)
            {
                return BadRequest("Partner not found");
            }
            await _credentialsRepo.Add(new Credentials
            {
                Username = credential.Username,
                Password = credential.Password,
                Role = credential.Role,
                PartnerId = credential.PartnerId,
                Partner = default!
            });
            return Ok(credential);
        }

        [HttpPut]
        public async Task<IActionResult> Put([FromBody] CredentialsPostPutDTO credential)
        {
            var credentials = await _credentialsRepo.GetCredentialsByPersonId(credential.PartnerId);
            if (credentials == null)
            {
                return NotFound(credential);
            }
            credentials.Username = credential.Username;
            credentials.Password = credential.Password;
            credentials.Role = credential.Role;
            var isUpdated = await _credentialsRepo.Update(credentials);
            if (!isUpdated)
            {
                return NotFound();
            }
            return Ok(credential);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var credentials = await _credentialsRepo.GetById(id);
            if (credentials == null)
            {
                return NotFound(credentials);
            }
            var isDeleted = await _credentialsRepo.Delete(credentials);
            if (!isDeleted)
            {
                return NotFound(id);
            }
            return Ok(credentials);
        }
    }
}
