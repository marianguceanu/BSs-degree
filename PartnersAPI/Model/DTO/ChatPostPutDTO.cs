using System.ComponentModel.DataAnnotations;

namespace PartnersAPI.Models.DTO
{
    public class ChatPostPutDTO
    {
        [Required]
        public int ChatId { get; set; }
    }
}