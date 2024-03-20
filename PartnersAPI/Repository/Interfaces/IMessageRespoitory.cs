using PartnersAPI.Models;

namespace PartnersAPI.Repository.Interfaces
{
    public interface IMessageRepository : IGenericRepository<Message>
    {
        public Task<IEnumerable<Message>?> GetMessageByChatId(int chatId);
    }
}
