using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PartnersAPI.Models
{
	public class PartnerChatConnectionTable
	{
		[Key]
		public int PartnerChatId { get; set; }
		[ForeignKey("PartnerId")]
		public int PartnerId { get; set; }
		[NotMapped]
		public virtual Partner Partner { get; set; } = default!;

		[ForeignKey("ChatId")]
		public int ChatId { get; set; }
		[NotMapped]
		public virtual Chat Chat { get; set; } = default!;
	}
}
