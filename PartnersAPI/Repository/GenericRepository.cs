using Microsoft.EntityFrameworkCore;
using PartnersAPI.DataContext;
using PartnersAPI.Repository.Interfaces;

namespace PartnersAPI.Repository
{
	public class GenericRepository<T> : IGenericRepository<T> where T : class
	{
		private readonly PartnersContext _context;
		public GenericRepository(PartnersContext context)
		{
			_context = context;
		}

		public async Task<bool> Add(T entity)
		{
			await _context.Set<T>().AddAsync(entity);
			return await SaveChanges();
		}

		public async Task<bool> Delete(T entity)
		{
			_context.Set<T>().Remove(entity);
			return await SaveChanges();
		}

		public async Task<IEnumerable<T>> GetAll()
		{
			return await _context.Set<T>().ToListAsync();
		}

		public async Task<T?> GetById(int id)
		{
			return await _context.Set<T>().FindAsync(id);
		}


		public async Task<bool> Update(T entity)
		{
			_context.Set<T>().Update(entity);
			return await SaveChanges();
		}

		public async Task<bool> SaveChanges()
		{
			return await _context.SaveChangesAsync() > 0;
		}
	}
}
