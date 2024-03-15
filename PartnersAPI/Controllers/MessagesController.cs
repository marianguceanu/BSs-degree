using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PartnersAPI.DataContext;
using PartnersAPI.Models;

namespace PartnersAPI.Controllers
{
	[ApiController]
	[Route("api/[controller]")]
	public class MessagesController : ControllerBase
	{
		private readonly PartnersContext _context;
		public MessagesController(PartnersContext context)
		{
			_context = context;
		}

		[HttpGet("all")]
		public async Task<IActionResult> Get()
		{
			var messages = await _context.Messages.ToListAsync();
			if (messages.Count == 0)
			{
				return NotFound();
			}

			return Ok(messages);
		}

		[HttpGet("{id}")]
		public async Task<IActionResult> Get(int id)
		{
			var message = await _context.Messages.FindAsync(id);
			if (message == null)
			{
				return NotFound();
			}
			return Ok(message);
		}

		[HttpPost]
		public async Task<IActionResult> Post([FromBody] Message message)
		{
			_context.Messages.Add(message);
			await _context.SaveChangesAsync();
			return Ok(message);
		}

		[HttpPut]
		public async Task<IActionResult> Put([FromBody] Message message)
		{
			var messageInDb = await _context.Messages.FindAsync(message.MessageId);
			if (messageInDb == null)
			{
				return NotFound();
			}
			_context.Messages.Update(message);
			await _context.SaveChangesAsync();
			return Ok(message);
		}

		[HttpDelete("{id}")]
		public async Task<IActionResult> Delete(int id)
		{
			var message = await _context.Messages.FindAsync(id);
			if (message == null)
			{
				return NotFound();
			}
			_context.Messages.Remove(message);
			await _context.SaveChangesAsync();
			return Ok(message);
		}
	}
}
