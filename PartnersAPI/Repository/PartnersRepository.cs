using Microsoft.EntityFrameworkCore;
using PartnersAPI.DataContext;
using PartnersAPI.Models;
using PartnersAPI.Repository.Interfaces;

namespace PartnersAPI.Repository
{
    public class PartnersRepository : GenericRepository<Partner>, IPartnersRepository
    {
        private readonly PartnersContext _context;
        public PartnersRepository(PartnersContext context) : base(context)
        {
            _context = context;
        }

        public Task<List<Partner>> GetAllByChatId(int chatId)
        {
            var pc = _context.PartnerChatConnections.Where(pc => pc.ChatId == chatId);
            return _context.Partners.Where(p => pc.Any(pc => pc.PartnerId == p.PartnerId)).ToListAsync();
        }
    }
}
