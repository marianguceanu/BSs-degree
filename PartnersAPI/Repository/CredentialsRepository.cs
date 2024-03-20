using Microsoft.EntityFrameworkCore;
using PartnersAPI.DataContext;
using PartnersAPI.Models;
using PartnersAPI.Repository.Interfaces;

namespace PartnersAPI.Repository
{
    public class CredentialsRepository : GenericRepository<Credentials>, ICredentialsRepository
    {
        private readonly PartnersContext _context = default!;
        public CredentialsRepository(PartnersContext context) : base(context)
        {
            _context = context;
        }
        public async Task<Credentials?> GetCredentialsByPersonId(int personId)
        {
            return await _context.Credentials.FirstOrDefaultAsync(c => c.PartnerId == personId);
        }
    }
}