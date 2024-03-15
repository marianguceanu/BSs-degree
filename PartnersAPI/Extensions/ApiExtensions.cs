namespace PartnersAPI.Extensions
{
	using Microsoft.EntityFrameworkCore;
	using Microsoft.Extensions.DependencyInjection;
	using PartnersAPI.DataContext;
	using PartnersAPI.Repository;
	using PartnersAPI.Repository.Interfaces;

	public static class ApiExtensions
	{
		public static IServiceCollection AddRepositories(this IServiceCollection services)
		{
			services.AddScoped(typeof(IGenericRepository<>), typeof(GenericRepository<>));
			services.AddScoped<IPartnerRepository, PartnersRepository>();
			services.AddScoped<IChatRepository, ChatRepository>();
			services.AddScoped<IMessageRepository, MessageRepository>();
			return services;
		}

		public static IServiceCollection AddDataContext(this IServiceCollection services, string connectionString)
		{
			services.AddDbContext<PartnersContext>(options => options.UseSqlServer(connectionString));
			return services;
		}
	}
}
