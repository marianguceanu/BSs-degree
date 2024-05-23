using Microsoft.AspNetCore.Mvc;
using PartnersAPI.Models;
using PartnersAPI.Models.DTO;
using PartnersAPI.Repository.Interfaces;

namespace PartnersAPI.Controllers
{
	[ApiController]
	[Route("api/[controller]")]
	public class MessagesController : ControllerBase
	{
		private readonly IMessageRepository _messageRepo;
		public MessagesController(IMessageRepository messageRepository)
		{
			_messageRepo = messageRepository;
		}

		[HttpGet("all")]
		public async Task<IActionResult> Get()
		{
			var messages = await _messageRepo.GetAll();
			if (messages == null)
			{
				return NotFound();
			}
			var mappedMessages = new List<MessagePostPutDTO>();
			foreach (var msg in messages)
			{
				var mappedMsg = new MessagePostPutDTO
				{
					MessageId = msg.MessageId,
					Text = msg.Text,
					SenderId = msg.SenderId,
					DateSent = msg.DateSent,
					IsRead = msg.IsRead
				};
				mappedMessages.Add(mappedMsg);
			}
			return Ok(mappedMessages);
		}

		[HttpGet("{id:int}")]
		public async Task<IActionResult> Get(int id)
		{
			var message = await _messageRepo.GetById(id);
			if (message == null)
			{
				return NotFound(id);
			}
			return Ok(message);
		}

		[HttpGet("byChatId/{chatId:int}")]
		public async Task<IActionResult> GetByChatId([FromRoute] int chatId)
		{
			var messages = await _messageRepo.GetByChatId(chatId);
			if (messages == null)
			{
				return NotFound(chatId);
			}
			var mappedMessages = new List<MessagePostPutDTO>();
			foreach (var msg in messages)
			{
				var mappedMsg = new MessagePostPutDTO
				{
					MessageId = msg.MessageId,
					Text = msg.Text,
					SenderId = msg.SenderId,
					DateSent = msg.DateSent,
					IsRead = msg.IsRead,
				};
				mappedMessages.Add(mappedMsg);
			}
			return Ok(mappedMessages);
		}

		[HttpPost]
		public async Task<IActionResult> Post([FromBody] MessagePostPutDTO messageDTO)
		{
			var message = new Message
			{
				MessageId = messageDTO.MessageId,
				Text = messageDTO.Text,
				SenderId = messageDTO.SenderId,
				DateSent = messageDTO.DateSent,
				IsRead = messageDTO.IsRead,
				ChatId = messageDTO.ChatId,
				Chat = default!
			};
			var isAdded = await _messageRepo.Add(message);
			if (!isAdded)
			{
				return BadRequest(messageDTO);
			}
			return Ok(message);
		}

		[HttpPut("{id:int}")]
		public async Task<IActionResult> Put([FromBody] MessagePostPutDTO messageDTO, [FromRoute] int id)
		{
			var message = new Message
			{
				MessageId = messageDTO.MessageId,
				Text = messageDTO.Text,
				SenderId = messageDTO.SenderId,
				DateSent = messageDTO.DateSent,
				IsRead = messageDTO.IsRead,
			};
			var isUpdated = await _messageRepo.Update(message);
			if (!isUpdated)
			{
				return NotFound(messageDTO);
			}
			return Ok(message);
		}

		[HttpDelete("{id:int}")]
		public async Task<IActionResult> Delete(int id)
		{
			var toDelete = await _messageRepo.GetById(id);
			if (toDelete == null)
			{
				return NotFound(id);
			}
			var isDeleted = await _messageRepo.Delete(toDelete);
			if (!isDeleted)
			{
				return NotFound();
			}
			return Ok(id);
		}
	}
}
