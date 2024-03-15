using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PartnersAPI.DataContext;
using PartnersAPI.Models;
using PartnersAPI.Models.DTO;

namespace PartnersAPI.Controllers
{

	[ApiController]
	[Route("[controller]")]
	public class PartnerController : ControllerBase
	{
		private readonly PartnersContext _context;
		public PartnerController(PartnersContext context)
		{
			_context = context;
		}

		[HttpGet("all")]
		public async Task<IActionResult> Get()
		{
			return Ok(await _context.Partners.ToListAsync());
		}

		[HttpGet("{id}")]
		public async Task<IActionResult> Get(int id)
		{
			return Ok(await _context.Partners.FindAsync(id));
		}

		[HttpPost]
		public async Task<IActionResult> Post([FromBody] PartnerPostDTO partner)
		{
			// TODO - add mappings
			await _context.Partners.AddAsync(new Partner
			{
				BusinessName = partner.BusinessName,
				Address = partner.Address,
				PhoneNumber = partner.PhoneNumber,
				ContactPerson = partner.ContactPerson,
				Email = partner.Email,
				Credentials = default!,
				PartnerChats = default!
			});
			// _context.Partners.Add(partner);
			await _context.SaveChangesAsync();
			return Ok(partner);
		}

		[HttpPut]
		public async Task<IActionResult> Put([FromBody] Partner partner)
		{
			_context.Partners.Update(partner);
			await _context.SaveChangesAsync();
			return Ok(partner);
		}

		[HttpDelete("{id}")]
		public async Task<IActionResult> Delete(int id)
		{
			var partner = await _context.Partners.FindAsync(id);
			_context.Partners.Remove(partner!);
			await _context.SaveChangesAsync();
			return Ok(partner!);
		}
	}
}
