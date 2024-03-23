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
		public ChatController(PartnersContext context, IChatRepository chatRepository, IPartnersRepository partnerRepository)
		{
			_chatRepo = chatRepository;
			_partnerRepo = partnerRepository;
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

		[HttpPost("{person1Id:int}/{person2Id:int}")]
		public async Task<IActionResult> Post([FromRoute] int person1Id, [FromRoute] int person2Id)
		{
			// Checking if the partners exist
			var person1 = await _partnerRepo.GetById(person1Id);
			var person2 = await _partnerRepo.GetById(person2Id);
			if (person1 == null || person2 == null)
			{
				return NotFound();
			}

			// Creating a new chat
			var chat = new Chat
			{
			};
			await _chatRepo.Add(chat);
			if (chat == null)
			{
				return NotFound();
			}
			await _chatRepo.SaveChanges();
			return Ok(chat);
		}

		// [HttpPut("addPartnerToChat/{partnerId:int}/{chatId:int}")]
		// public async Task<IActionResult> Put([FromRoute] int partnerId, [FromRoute] int chatId)
		// {
		// 	//  TODO: this update should in fact add a new PartnerChat instance to the DB with the chat id and the partner id
		// 	var partner = await _partnerRepo.GetById(partnerId);
		// 	if (partner == null)
		// 	{
		// 		return NotFound();
		// 	}
		// 	await _chatRepo.Update(chat);
		// 	return Ok(chat);
		// }
		//
		[HttpDelete("{id:int}")]
		public async Task<IActionResult> Delete(int id)
		{
			var chat = await _chatRepo.GetById(id);
			if (chat == null)
			{
				return NotFound();
			}
			await _chatRepo.Delete(chat);
			return Ok(chat!);
		}

	}
}
