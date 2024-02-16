using MongoDB.Bson.Serialization.Attributes;

namespace green_backend.Models;

[BsonIgnoreExtraElements]
public class SemveraUser
{
    public string Username { get; set; }

    public string Password { get; set; }

    public string Email { get; set; }

    public string Description { get; set; }

    //public string Title { get; set; }

    //public string GitHubURL { get; set; }

    //public string ProfilePictureURL { get; set; }

    //public List<string> Followers { get; set; }

    //public List<string> Following { get; set; }
    public int TreesPlanted { get; set; }

    public int ProblemsSolved { get; set; }

    public string JoinedAt { get; set; }

    //public bool IsActive { get; set; }

    //public string IsPremium { get; set; }

    public SemveraUser(string email, string password, string username) 
    { 
        Email = email;
        Password = password;
        Username = username;
        Description = "";
        TreesPlanted = 0;
        ProblemsSolved = 0;
        JoinedAt = DateTime.Now.ToString();
    }
}
