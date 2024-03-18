using System.Net;
using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using PartnersAPI.Exceptions;

namespace PartnersAPI.Middleware
{
    public class ErrorHandlerMiddleware : IMiddleware
    {
        public async Task InvokeAsync(HttpContext context, RequestDelegate next)
        {
            try
            {
                await next(context);
            }
            catch (Exception exception)
            {
                var response = context.Response;
                response.ContentType = "application/json";

                ProblemDetails error;

                switch (exception)
                {
                    case AuthenticationException:
                        error = new ProblemDetails
                        {
                            Status = (int)HttpStatusCode.NotFound,
                            Type = "authentication-error",
                            Title = "Authentication failed",
                            Detail = "Authentication error, please input correct username and password"
                        };
                        break;
                    case AuthorizationException:
                        error = new ProblemDetails
                        {
                            Status = (int)HttpStatusCode.Unauthorized,
                            Type = "authorization-error",
                            Title = "Authorization failed",
                            Detail = "Authorization error, this operation is not allowed for your user type",

                        };
                        break;
                    case DataValidationException:
                        error = new ProblemDetails
                        {
                            Status = (int)HttpStatusCode.BadRequest,
                            Type = "data-validation-error",
                            Title = "Data validation failed",
                            Detail = "Data validation error, please check your input data"
                        };
                        break;
                    default:
                        error = new ProblemDetails();
                        break;
                }
                var result = JsonSerializer.Serialize(error);
                context.Response.StatusCode = error.Status.GetValueOrDefault((int)HttpStatusCode.InternalServerError);
                await response.WriteAsync(result);
            }
        }
    }
}