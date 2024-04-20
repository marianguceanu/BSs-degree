using PartnersAPI.Models;

namespace PartnersAPI.Repository.Interfaces
{
	public interface IMessageRepository : IGenericRepository<Message>
	{
		public Task<IList<Message>?> GetByChatId(int chatId);
	}
}
