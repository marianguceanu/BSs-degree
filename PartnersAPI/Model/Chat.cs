using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PartnersAPI.Models
{
	public class Chat
	{
		[Key]
		public int ChatId { get; set; }

		[NotMapped]
		public virtual ICollection<Message> Messages { get; set; } = default!;
	}
}
