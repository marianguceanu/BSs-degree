using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PartnersAPI.Models
{
	public class Message
	{
		[Key]
		public int MessageId { get; set; }

		[ForeignKey("ChatId")]
		public int ChatId { get; set; }
		[NotMapped]
		public virtual Chat Chat { get; set; } = default!;

		[Required]
		public string Text { get; set; } = string.Empty;
		[Required]
		public int SenderId { get; set; }
		[Required]
		public DateTime DateSent { get; set; }
		[Required]
		public bool IsRead { get; set; }
	}
}
