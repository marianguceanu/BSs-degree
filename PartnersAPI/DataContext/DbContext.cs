using Microsoft.EntityFrameworkCore;
using PartnersAPI.Models;

namespace PartnersAPI.DataContext
{
	public class PartnersContext : DbContext
	{
		public PartnersContext(DbContextOptions<PartnersContext> options) : base(options) { }
		public DbSet<Partner> Partners { get; set; }
		public DbSet<Credentials> Credentials { get; set; }
		public DbSet<Chat> Chats { get; set; }
		public DbSet<Message> Messages { get; set; }
		public DbSet<PartnerChatConnectionTable> PartnerChatConnections { get; set; }


		protected override void OnModelCreating(ModelBuilder modelBuilder)
		{
			modelBuilder.Entity<Partner>()
				.HasOne(p => p.Credentials)
				.WithOne(c => c.Partner)
				.HasForeignKey<Credentials>(c => c.PartnerId);

			modelBuilder.Entity<Message>()
				.HasOne(m => m.Chat)
				.WithMany(c => c.Messages)
				.HasForeignKey(m => m.ChatId)
				.OnDelete(DeleteBehavior.Cascade);

			modelBuilder.Entity<PartnerChatConnectionTable>()
				.HasOne(pc => pc.Partner)
				.WithMany(p => p.PartnerChats)
				.HasForeignKey(pc => pc.PartnerId);

			modelBuilder.Entity<PartnerChatConnectionTable>()
				.HasOne(pc => pc.Chat)
				.WithMany(c => c.PartnerChats)
				.HasForeignKey(pc => pc.ChatId);

			// modelBuilder.Entity<PartnerChatConnectionTable>()
			// 	.HasKey(pc => new { pc.PartnerId, pc.ChatId });
		}
	}
}
