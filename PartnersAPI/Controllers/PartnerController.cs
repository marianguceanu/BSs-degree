using Microsoft.AspNetCore.Mvc;
using PartnersAPI.Models;
using PartnersAPI.Models.DTO;
using PartnersAPI.Repository.Interfaces;

namespace PartnersAPI.Controllers
{

	[ApiController]
	[Route("api/[controller]")]
	public class PartnerController : ControllerBase
	{
		private readonly IPartnersRepository _partnersRepo;
		public PartnerController(IPartnersRepository partnersRepository)
		{
			_partnersRepo = partnersRepository;
		}

		[HttpGet("all")]
		public async Task<IActionResult> Get()
		{
			var partners = await _partnersRepo.GetAll();
			if (partners == null)
			{
				return NotFound();
			}
			return Ok(partners);
		}

		[HttpGet("{id:int}")]
		public async Task<IActionResult> Get(int id)
		{
			var partner = await _partnersRepo.GetById(id);
			if (partner == null)
			{
				return NotFound();
			}
			var partnerDTO = new PartnerPostPutDTO
			{
				BusinessName = partner.BusinessName,
				Address = partner.Address,
				PhoneNumber = partner.PhoneNumber,
				ContactPerson = partner.ContactPerson,
				Email = partner.Email
			};
			return Ok(partnerDTO);
		}

		[HttpPost]
		public async Task<IActionResult> Post([FromBody] PartnerPostPutDTO partner)
		{
			var isAdded = await _partnersRepo.Add(new Partner
			{
				BusinessName = partner.BusinessName,
				Address = partner.Address,
				PhoneNumber = partner.PhoneNumber,
				ContactPerson = partner.ContactPerson,
				Email = partner.Email,
				Credentials = default!,
				PartnerChats = default!
			});
			if (!isAdded)
			{
				return NotFound(partner);
			}
			return Ok(partner);
		}

		[HttpPut("{id:int}")]
		public async Task<IActionResult> Put([FromRoute] int id, [FromBody] PartnerPostPutDTO partnerNewDetails)
		{
			var partner = await _partnersRepo.GetById(id);
			if (partner == null)
			{
				return NotFound(id);
			}
			partner.BusinessName = partnerNewDetails.BusinessName;
			partner.Email = partnerNewDetails.Email;
			partner.ContactPerson = partnerNewDetails.ContactPerson;
			partner.PhoneNumber = partnerNewDetails.PhoneNumber;
			partner.Address = partnerNewDetails.Address;
			await _partnersRepo.Update(partner);
			var updatedPartnerDTO = new PartnerPostPutDTO
			{
				BusinessName = partner.BusinessName,
				Address = partner.Address,
				PhoneNumber = partner.PhoneNumber,
				ContactPerson = partner.ContactPerson,
				Email = partner.Email
			};
			return Ok(updatedPartnerDTO);
		}

		[HttpDelete("{id:int}")]
		public async Task<IActionResult> Delete(int id)
		{
			var partner = await _partnersRepo.GetById(id);
			if (partner == null)
			{
				return NotFound(id);
			}
			await _partnersRepo.Delete(partner);
			return Ok(partner);
		}
	}
}
