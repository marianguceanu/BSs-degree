using PartnersAPI.Models;

namespace PartnersAPI.Repository.Interfaces
{
    public interface IPartnersRepository : IGenericRepository<Partner>
    {
        public Task<List<Partner>> GetAllByChatId(int chatId);
    }
}

