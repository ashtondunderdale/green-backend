using Microsoft.AspNetCore.Mvc;
using MongoDB.Driver;

namespace green_backend.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class GreenController : ControllerBase
    {
        private readonly ILogger<GreenController> _logger;
        private readonly IConfiguration _configuration;

        public GreenController(ILogger<GreenController> logger, IConfiguration configuration)
        {
            _logger = logger;
            _configuration = configuration; 
        }

        [HttpGet("GetQuestions")]
        public IActionResult GetQuestionData()
        {
            string connectionString = _configuration.GetValue<string>("ConnectionString");

            MongoClient client = new(connectionString);
            var dbs = client.ListDatabaseNames().ToList();
                
            return Ok("got questions from mongodb");
        }
    }
}
