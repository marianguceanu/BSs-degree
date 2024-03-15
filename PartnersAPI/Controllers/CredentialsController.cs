using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PartnersAPI.DataContext;
using PartnersAPI.Models;
using PartnersAPI.Models.DTO;

namespace PartnersAPI.Controllers
{
	[ApiController]
	[Route("[controller]")]
	public class CredentialsController : ControllerBase
	{
		private readonly PartnersContext _context;
		public CredentialsController(PartnersContext context)
		{
			_context = context;
		}

		[HttpGet("all")]
		public async Task<IActionResult> Get()
		{
			return Ok(await _context.Credentials.ToListAsync());
		}

		[HttpGet("{id}")]
		public async Task<IActionResult> Get(int id)
		{
			return Ok(await _context.Credentials.FindAsync(id));
		}

		[HttpPost]
		public async Task<IActionResult> Post([FromBody] CredentialsPostDTO credential)
		{
			var partner = await _context.Partners.FindAsync(credential.PartnerId);
			if (partner == null)
			{
				return BadRequest("Partner not found");
			}
			// TODO - add mappings
			await _context.Credentials.AddAsync(new Credentials
			{
				Username = credential.Username,
				Password = credential.Password,
				Role = credential.Role,
				PartnerId = credential.PartnerId,
				Partner = default!
			});
			// _context.Credentials.Add(credential);
			await _context.SaveChangesAsync();
			return Ok(credential);
		}

		[HttpPut]
		public async Task<IActionResult> Put([FromBody] Credentials credential)
		{
			_context.Credentials.Update(credential);
			await _context.SaveChangesAsync();
			return Ok(credential);
		}

		[HttpDelete("{id}")]
		public async Task<IActionResult> Delete(int id)
		{
			var credential = await _context.Credentials.FindAsync(id);
			_context.Credentials.Remove(credential!);
			await _context.SaveChangesAsync();
			return Ok(credential!);
		}
	}
}
