namespace PartnersAPI.Models.DTO
{
    public class CredentialsPostPutDTO
    {
        public string Username { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string Role { get; set; } = string.Empty;
        public int PartnerId { get; set; }
    }
}
