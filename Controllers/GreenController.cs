using green_backend.Models;
using Microsoft.AspNetCore.Mvc;
using MongoDB.Driver;

namespace green_backend.Controllers;

[ApiController]
[Route("[controller]")]
public class GreenController : ControllerBase
{
    private readonly ILogger<GreenController> _logger;
    private readonly IMongoClient _mongoClient;

    public GreenController(ILogger<GreenController> logger, IMongoClient mongoClient)
    {
        _logger = logger;
        _mongoClient = mongoClient; 
    }

    [HttpGet("GetQuestions")]
    public IActionResult GetQuestions()
    {
        var db = _mongoClient.GetDatabase("15750c77-1a68-49c4-b02e-70fa43eab052");
        var collection = db.GetCollection<Question>("Questions");

        var filter = Builders<Question>.Filter.Empty;
        var documents = collection.Find(filter).ToList();

        List<Question> questions = new();
        foreach (var document in documents) 
        {
            questions.Add(new(document.Prompt, document.Answer, document.Language, document.Difficulty, document.Author, document.Votes, document.Views, document.Rating, document.QuestionNumber));
        }


        return Ok(questions);
    }
}
