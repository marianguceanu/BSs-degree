using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PartnersAPI.Models
{
	public class Credentials
	{
		[Key]
		public int CredentialsId { get; set; }
		[Required]
		public string Username { get; set; } = string.Empty;
		[Required]
		public string Password { get; set; } = string.Empty;
		[Required]
		public string Role { get; set; } = string.Empty;

		[ForeignKey("PartnerId")]
		public int PartnerId { get; set; }
		[NotMapped]
		public virtual Partner Partner { get; set; } = default!;
	}
}
