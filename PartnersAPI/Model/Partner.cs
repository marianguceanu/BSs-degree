namespace PartnersAPI.Models
{
    public class Partner
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Address { get; set; } = string.Empty;
        public string PhoneNumber { get; set; } = string.Empty;
        public string OwnerPhoneNumber { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
    }
}
