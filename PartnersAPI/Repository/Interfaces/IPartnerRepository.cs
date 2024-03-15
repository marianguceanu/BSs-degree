using PartnersAPI.Models;

namespace PartnersAPI.Repository.Interfaces
{
	public interface IPartnerRepository : IGenericRepository<Partner>
	{
		public Task<Partner?> GetByUsername(string businessName);
		public Task<List<Partner>> GetAllByChatId(int chatId);
	}
}

