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

		[HttpPost("{type}/{person1Id:int}/{person2Id:int}")]
		public async Task<IActionResult> Add([FromRoute] string type, [FromRoute] int person1Id, [FromRoute] int person2Id)
		{
			// Checking if the partners exist
			var person1 = await _partnerRepo.GetById(person1Id);
			var person2 = await _partnerRepo.GetById(person2Id);
			if (person1 == null || person2 == null)
			{
				return NotFound("One or both of the partners do not exist");
			}

			if (type != "private" && type != "group")
			{
				return BadRequest("Invalid chat type");
			}

			// Checking for existing chats, because private chats should not have duplicates
			if (type == "private")
			{
				var allPCs = await _pcRepo.GetAll();
				foreach (var pc in allPCs)
				{
					if (pc.PartnerId == person1.PartnerId)
					{
						foreach (var pcSecond in allPCs)
						{
							if (pcSecond.PartnerId == person2.PartnerId)
							{
								if (pc.ChatId == pcSecond.ChatId)
								{
									return BadRequest("Chat already exists");
								}
							}
						}
					}

					if (pc.PartnerId == person2.PartnerId)
					{
						foreach (var pcSecond in allPCs)
						{
							if (pcSecond.PartnerId == person1.PartnerId)
							{
								if (pc.ChatId == pcSecond.ChatId)
								{
									return BadRequest("Chat already exists");
								}
							}
						}
					}
				}
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

			var pc1 = new PartnerChatConnectionTable
			{
				ChatId = chat.ChatId,
				PartnerId = person1.PartnerId,
			};
			bool isPC1Added = await _pcRepo.Add(pc1);

			var pc2 = new PartnerChatConnectionTable
			{
				ChatId = chat.ChatId,
				PartnerId = person2.PartnerId,
			};

			bool isPC2Added = await _pcRepo.Add(pc2);
			if (!isPC1Added || !isPC2Added)
			{
				return BadRequest("Could not resolve the connection between the chat and the partner");
			}
			return Ok(chat);
		}

		[HttpPut("addPartnerToChat/{partnerId:int}/{chatId:int}")]
		public async Task<IActionResult> Update([FromRoute] int partnerId, [FromRoute] int chatId)
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
