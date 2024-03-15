using PartnersAPI.DataContext;
using PartnersAPI.Models;
using PartnersAPI.Repository.Interfaces;

namespace PartnersAPI.Repository
{
	public class ChatRepository : GenericRepository<Chat>, IChatRepository
	{
		private readonly PartnersContext _context;
		public ChatRepository(PartnersContext context) : base(context)
		{
			_context = context;
		}
	}
}
