using PartnersAPI.Models;

namespace PartnersAPI.Repository.Interfaces
{
    public interface ICredentialsRepository : IGenericRepository<Credentials>
    {
        public Task<Credentials?> GetCredentialsByPersonId(int personId);
    }
}
