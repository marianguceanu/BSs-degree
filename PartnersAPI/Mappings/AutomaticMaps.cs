using AutoMapper;
using PartnersAPI.Models;
using PartnersAPI.Models.DTO;

namespace PartnersAPI.Mappings
{
    public class Mappings : Profile
    {
        MapperConfiguration config { get; set; } = new(cfg =>
           {
               cfg.CreateMap<Partner, PartnerPostPutDTO>();
               cfg.CreateMap<PartnerPostPutDTO, Partner>();
           });
    }
}