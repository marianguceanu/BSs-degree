using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PartnersAPI.DataContext;
using PartnersAPI.Models;

namespace PartnersAPI.Controllers
{
	[ApiController]
	[Route("api/[controller]")]
	public class ChatController : ControllerBase
	{
		private readonly PartnersContext _context;
		public ChatController(PartnersContext context)
		{
			_context = context;
		}

		[HttpGet("get/all")]
		public async Task<IActionResult> Get()
		{
			var chats = await _context.Chats.ToListAsync();
			if (chats.Count == 0)
			{
				return NotFound();
			}

			return Ok(chats);
		}

		[HttpGet("get/{id}")]
		public async Task<IActionResult> Get(int id)
		{
			var chat = await _context.Chats.FindAsync(id);
			if (chat == null)
			{
				return NotFound();
			}
			return Ok(chat);
		}

		[HttpPost("add/{person1Id}/{person2Id}")]
		public async Task<IActionResult> Post([FromRoute] int person1Id, [FromRoute] int person2Id)
		{
			// Checking if the partners exist
			var person1 = await _context.Partners.FindAsync(person1Id);
			var person2 = await _context.Partners.FindAsync(person2Id);
			if (person1 == null || person2 == null)
			{
				return NotFound();
			}

			// Creating a new chat
			var chat = new Chat
			{
			};
			await _context.Chats.AddAsync(chat);
			await _context.SaveChangesAsync();
			var savedChat = await _context.Chats.FindAsync(chat.ChatId);
			if (savedChat == null)
			{
				return NotFound();
			}

			await _context.SaveChangesAsync();
			await _context.SaveChangesAsync();
			return Ok(savedChat);
		}

		[HttpPut("/update")]
		public async Task<IActionResult> Put([FromBody] Chat chat)
		{
			var chatInDb = await _context.Chats.FindAsync(chat.ChatId);
			if (chatInDb == null)
			{
				return NotFound();
			}
			_context.Chats.Update(chat);
			await _context.SaveChangesAsync();
			return Ok(chat);
		}

		[HttpDelete("delete/{id}")]
		public async Task<IActionResult> Delete(int id)
		{
			var chat = await _context.Chats.FindAsync(id);
			if (chat == null)
			{
				return NotFound();
			}
			_context.Chats.Remove(chat);
			await _context.SaveChangesAsync();
			return Ok(chat!);
		}

	}
}
