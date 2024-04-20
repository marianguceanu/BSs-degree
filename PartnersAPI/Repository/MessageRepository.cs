using Microsoft.EntityFrameworkCore;
using PartnersAPI.DataContext;
using PartnersAPI.Models;
using PartnersAPI.Repository.Interfaces;

namespace PartnersAPI.Repository
{
	public class MessageRepository : GenericRepository<Message>, IMessageRepository
	{
		private readonly PartnersContext _context;
		public MessageRepository(PartnersContext context) : base(context)
		{
			_context = context;
		}
		public async Task<IList<Message>?> GetByChatId(int chatId)
		{
			return await _context.Messages.Where(msg => msg.ChatId == chatId).ToListAsync();
		}
	}
}
