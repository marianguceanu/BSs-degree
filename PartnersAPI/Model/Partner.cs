using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PartnersAPI.Models
{
	public class Partner
	{
		[Key]
		public int PartnerId { get; set; }
		[Required]
		public string BusinessName { get; set; } = string.Empty;
		[Required]
		public string Address { get; set; } = string.Empty;
		[Required]
		public string PhoneNumber { get; set; } = string.Empty;
		[Required]
		public string ContactPerson { get; set; } = string.Empty;
		[Required]
		public string Email { get; set; } = string.Empty;

		[NotMapped]
		public virtual Credentials Credentials { get; set; } = default!;
	}
}
