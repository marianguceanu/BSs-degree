using System.ComponentModel.DataAnnotations;

namespace PartnersAPI.Models
{
	public class PartnerChatConnectionTable
	{
		[Key]
		public int PartnerChatId { get; set; }
		public int PartnerId { get; set; }
		public Partner Partner { get; set; } = default!;
		public int ChatId { get; set; }
		public Chat Chat { get; set; } = default!;
	}
}
