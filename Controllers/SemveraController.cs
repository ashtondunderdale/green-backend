using green_backend.Models;
using green_backend.Requests;
using green_backend.Responses;

using Microsoft.AspNetCore.Mvc;
using MongoDB.Driver;
using BCrypt.Net;

namespace green_backend.Controllers;

[ApiController]
[Route("[controller]")]
public class SemveraController : ControllerBase
{
    private readonly IMongoClient _mongoClient;

    public SemveraController(IMongoClient mongoClient)
    {
        _mongoClient = mongoClient; 
    }

    [HttpPost("AddPreLaunchEmail")]
    public IActionResult AddPreLaunchEmail(PreLaunchUserRequest request) 
    {
        try 
        {
            var db = _mongoClient.GetDatabase("29209dd4-b715-4ec8-b5ae-c0020d967191");
            var collection = db.GetCollection<PreLaunchUser>("PreLaunchEmails");

            var document = new PreLaunchUser(request.EmailAddress!, request.Name!, request.TimeStamp!);
            collection.InsertOne(document);

            return Ok();
        }
        catch (Exception e)
        {
            return BadRequest(e.Message);
        }
    }

    [HttpPost("TryRegister")]
    public IActionResult TryRegister(RegisterRequest request) 
    {
        try
        {
            APIResponse response = new();

            var db = _mongoClient.GetDatabase("29209dd4-b715-4ec8-b5ae-c0020d967191");
            var collection = db.GetCollection<SemveraUser>("Users");

            var filter = Builders<SemveraUser>.Filter.Empty;
            var documents = collection.Find(filter).ToList();

            var existingUser = documents.FirstOrDefault(u => u.Email == request.Email || u.Username == request.Username);

            if (existingUser is not null)
            {
                if (existingUser.Email == request.Email) response.Message = "User with that email already exists";
                else response.Message = "User with that username already exists";

                response.Success = false;

                return Ok(response);
            }

            if (request.Email is not null && request.Password is not null && request.Username is not null) 
            {
                string hashedPassword = BCrypt.Net.BCrypt.HashPassword(request.Password);

                SemveraUser user = new(request.Email, hashedPassword, request.Username);
                collection.InsertOne(user);

                response.Success = true;
            }

            return Ok(response);
        }
        catch (Exception e)
        {
            return BadRequest(e.Message);
        }
    }

    [HttpPost("TryLogin")]
    public IActionResult TryLogin(LoginRequest request) 
    {
        try
        {
            APIResponse response = new();
            
            var db = _mongoClient.GetDatabase("29209dd4-b715-4ec8-b5ae-c0020d967191");
            var collection = db.GetCollection<SemveraUser>("Users");

            var filter = Builders<SemveraUser>.Filter.Empty;
            var documents = collection.Find(filter).ToList();

            var user = documents.FirstOrDefault(u => u.Username == request.Username);

            if (user is not null && BCrypt.Net.BCrypt.Verify(request.Password, user.Password))
            {
                response.Success = true;
                return Ok(response);
            }

            response.Message = "User not found or incorrect login details";
            response.Success = false;

            return Ok(response);
        }
        catch (Exception e) 
        {
            return BadRequest(e.Message);
        }
    }

/*    [HttpGet("GetQuestions")]
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
    }*/
}


// template
/*[HttpPost("APINAME")]
public IActionResult APINAME()
{
    try
    {


        return Ok();
    }
    catch (Exception e)
    {
        return BadRequest(e.Message);
    }
}*/