using Microsoft.AspNetCore.Mvc;
using PartnersAPI.Models;
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

            return Ok(messages);
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
            var messages = await _messageRepo.GetMessageByChatId(chatId);
            if (messages == null)
            {
                return NotFound(chatId);
            }
            return Ok(messages);
        }

        [HttpPost]
        public async Task<IActionResult> Post([FromBody] Message message)
        {
            var isAdded = await _messageRepo.Add(message);
            if (!isAdded)
            {
                return BadRequest(message);
            }
            return Ok(message);
        }

        [HttpPut("id:int")]
        public async Task<IActionResult> Put([FromBody] Message message, [FromRoute] int id)
        {
            var isUpdated = await _messageRepo.Update(message);
            if (!isUpdated)
            {
                return NotFound(message);
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
