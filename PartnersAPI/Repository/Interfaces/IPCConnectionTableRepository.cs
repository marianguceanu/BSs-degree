using PartnersAPI.Models;

namespace PartnersAPI.Repository.Interfaces
{
	public interface IPCConnectionTableRepository : IGenericRepository<PartnerChatConnectionTable>
	{
		public Task<IList<PartnerChatConnectionTable>> GetByChatId(int chatId);
		public Task<IList<PartnerChatConnectionTable>> GetByPartnerId(int partnerId);
	}
}
