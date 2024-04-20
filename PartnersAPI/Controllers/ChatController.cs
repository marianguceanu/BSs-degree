using Microsoft.AspNetCore.Mvc;
using PartnersAPI.DataContext;
using PartnersAPI.Models;
using PartnersAPI.Repository.Interfaces;

namespace PartnersAPI.Controllers
{
	[ApiController]
	[Route("api/[controller]")]
	public class ChatController : ControllerBase
	{
		private readonly IChatRepository _chatRepo;
		private readonly IPartnersRepository _partnerRepo;
		private readonly IPCConnectionTableRepository _pcRepo;
		private readonly IMessageRepository _messageRepo;
		public ChatController(PartnersContext context, IChatRepository chatRepository, IPartnersRepository partnerRepository, IPCConnectionTableRepository pcRepo, IMessageRepository messageRepository)
		{
			_chatRepo = chatRepository;
			_partnerRepo = partnerRepository;
			_pcRepo = pcRepo;
			_messageRepo = messageRepository;
		}

		[HttpGet("all")]
		public async Task<IActionResult> Get()
		{
			var chats = await _chatRepo.GetAll();
			if (chats == null)
			{
				return NotFound();
			}

			return Ok(chats);
		}

		[HttpGet("{id:int}")]
		public async Task<IActionResult> Get(int id)
		{
			var chat = await _chatRepo.GetById(id);
			if (chat == null)
			{
				return NotFound();
			}
			return Ok(chat);
		}

		[HttpGet("pc")]
		public async Task<IActionResult> GetAllPC()
		{
			var pcs = await _pcRepo.GetAll();
			if (pcs == null)
			{
				return NotFound();
			}
			return Ok(pcs);
		}

		[HttpPost("{person1Id:int}/{person2Id:int}")]
		public async Task<IActionResult> Post([FromRoute] int person1Id, [FromRoute] int person2Id)
		{
			// Checking if the partners exist
			var person1 = await _partnerRepo.GetById(person1Id);
			var person2 = await _partnerRepo.GetById(person2Id);
			if (person1 == null)
			{
				return NotFound(person1Id);
			}
			if (person2 == null)
			{
				return NotFound(person2Id);
			}

			// Creating a new chat
			var chat = new Chat
			{
			};
			bool isChatAdded = await _chatRepo.Add(chat);
			if (!isChatAdded)
			{
				return BadRequest();
			}
			return Ok(chat);
		}

		[HttpPut("addPartnerToChat/{partnerId:int}/{chatId:int}")]
		public async Task<IActionResult> Put([FromRoute] int partnerId, [FromRoute] int chatId)
		{
			var partner = await _partnerRepo.GetById(partnerId);
			if (partner == null)
			{
				return NotFound();
			}
			var chat = await _chatRepo.GetById(chatId);
			if (chat == null)
			{
				return NotFound();
			}
			var pc = new PartnerChatConnectionTable
			{
				ChatId = chatId,
				PartnerId = partnerId
			};
			bool isPCAdded = await _pcRepo.Add(pc);
			if (!isPCAdded)
			{
				return BadRequest("Could not resolve the connection between the chat and the partner");
			}
			var allPC = await _pcRepo.GetAll();
			return Ok(partner);
		}

		[HttpDelete("{id:int}")]
		public async Task<IActionResult> Delete(int id)
		{
			var chat = await _chatRepo.GetById(id);
			if (chat == null)
			{
				return NotFound();
			}
			bool isDeleted = await _chatRepo.Delete(chat);
			if (!isDeleted)
			{
				return BadRequest("Could not delete the chat");
			}


			var messages = await _messageRepo.GetByChatId(id);
			if (messages == null)
			{
				return BadRequest("Could not delete messages attached to chat");
			}
			return Ok(chat!);
		}

	}
}
