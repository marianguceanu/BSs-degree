using System.ComponentModel.DataAnnotations;

namespace PartnersAPI.Models.DTO
{
    public class MessagePostPutDTO
    {
        [Key]
        public int MessageId { get; set; }
        public int ChatId { get; set; }
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