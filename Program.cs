using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.OpenApi.Models;
using MongoDB.Driver;
using green_backend.Settings;

namespace green_backend
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            var config = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build();

            var mongoSettings = config.GetSection("MongoSettings").Get<MongoSettings>();
            builder.Services.AddSingleton<IMongoClient>(mc => new MongoClient(mongoSettings.ConnectionString));

            builder.Services.AddControllers();

            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen(mc =>
            {
                mc.SwaggerDoc("v1", new OpenApiInfo { Title = "My API", Version = "v1" });
            });

            var app = builder.Build();

            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI(mc => mc.SwaggerEndpoint("/swagger/v1/swagger.json", "My API V1"));
            }

            app.UseHttpsRedirection();

            app.UseAuthorization();

            app.MapControllers();

            app.Run();
        }
    }
}
