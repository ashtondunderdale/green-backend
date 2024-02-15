using green_backend.Models;
using green_backend.Requests;
using Microsoft.AspNetCore.Mvc;
using MongoDB.Driver;

namespace green_backend.Controllers;

[ApiController]
[Route("[controller]")]
public class GreenController : ControllerBase
{
    private readonly IMongoClient _mongoClient;

    public GreenController(IMongoClient mongoClient)
    {
        _mongoClient = mongoClient; 
    }

    [HttpGet("GetQuestions")]
    [ProducesResponseType(200, Type = typeof(List<Question>))]
    public IActionResult GetQuestions()
    {
        try 
        {
            var db = _mongoClient.GetDatabase("15750c77-1a68-49c4-b02e-70fa43eab052");
            var collection = db.GetCollection<Question>("Questions");

            var filter = Builders<Question>.Filter.Empty;
            var documents = collection.Find(filter).ToList();

            List<Question> questions = documents.Select(document => new Question(
                document.Prompt, document.Answer, document.Language, document.Difficulty, document.Author,
                document.Votes, document.Views, document.Rating, document.QuestionNumber
            )).ToList();

            return Ok(questions);
        }
        catch (Exception e) 
        {
            return BadRequest(e.Message);
        }

    }

    [HttpPost("AddPreLaunchEmail")]
    [ProducesResponseType(200, Type = typeof(List<Question>))]
    public IActionResult AddPreLaunchEmail(EmailRequest request) 
    {
        try 
        {
            var db = _mongoClient.GetDatabase("29209dd4-b715-4ec8-b5ae-c0020d967191");
            var collection = db.GetCollection<Email>("PreLaunchEmails");

            var document = new Email(request.Email!);
            collection.InsertOne(document);

            return Ok();
        }
        catch (Exception e)
        {
            return BadRequest(e.Message);
        }
    }
}
