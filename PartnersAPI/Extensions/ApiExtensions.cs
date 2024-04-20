using Microsoft.EntityFrameworkCore;
using PartnersAPI.DataContext;
using PartnersAPI.Middleware;
using PartnersAPI.Repository;
using PartnersAPI.Repository.Interfaces;

namespace PartnersAPI.Extensions
{

	public static class ApiExtensions
	{
		public static IServiceCollection AddRepositories(this IServiceCollection services)
		{
			services.AddScoped(typeof(IGenericRepository<>), typeof(GenericRepository<>));
			services.AddScoped<IPartnersRepository, PartnersRepository>();
			services.AddScoped<IChatRepository, ChatRepository>();
			services.AddScoped<ICredentialsRepository, CredentialsRepository>();
			services.AddScoped<IMessageRepository, MessageRepository>();
			services.AddScoped<IPCConnectionTableRepository, PCConnectionTableRepository>();
			return services;
		}

		public static IServiceCollection AddDataContext(this IServiceCollection services, string connectionString)
		{
			services.AddDbContext<PartnersContext>(options => options.UseSqlServer(connectionString));
			return services;
		}
		public static IServiceCollection AddDataContextInMemory(this IServiceCollection services, string connectionString)
		{
			services.AddDbContext<PartnersContext>(options => options.UseInMemoryDatabase(connectionString));
			return services;
		}

		public static IServiceCollection AddMiddlewares(this IServiceCollection services)
		{
			services.AddScoped<ErrorHandlerMiddleware>();
			services.AddCors();
			return services;
		}
	}
}
