using Microsoft.EntityFrameworkCore;
using PartnersAPI.DataContext;
using PartnersAPI.Models;
using PartnersAPI.Repository.Interfaces;

namespace PartnersAPI.Repository
{
	public class PCConnectionTableRepository : GenericRepository<PartnerChatConnectionTable>, IPCConnectionTableRepository
	{
		private readonly PartnersContext _context;
		public PCConnectionTableRepository(PartnersContext context) : base(context)
		{
			_context = context;
		}

		public async Task<IList<PartnerChatConnectionTable>> GetByChatId(int chatId)
		{
			var connections = await _context.PartnerChatConnections.Where(c => c.ChatId == chatId).ToListAsync();
			return connections;
		}

		public async Task<IList<PartnerChatConnectionTable>> GetByPartnerId(int partnerId)
		{
			var connections = await _context.PartnerChatConnections.Where(c => c.PartnerId == partnerId).ToListAsync();
			return connections;
		}
	}
}
