using System.ComponentModel.DataAnnotations;

namespace PartnersAPI.Models
{
	public class PartnerChatConnectionTable
	{
		[Key]
		public int PartnerChatId { get; set; }
		public int PartnerId { get; set; }
		public int ChatId { get; set; }
	}
}
