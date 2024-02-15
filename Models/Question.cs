using MongoDB.Bson.Serialization.Attributes;

namespace green_backend.Models;

[BsonIgnoreExtraElements]
public class Question
{
    public Guid ObjectID { get; set; }

    public string Prompt { get; set; }

    public string Answer { get; set; }

    public string Language { get; set; }

    public string Difficulty { get; set; }

    public string Author { get; set; }

    public int Votes { get; set; }

    public int Views { get; set; }

    public double Rating { get; set; }

    public int QuestionNumber { get; set; }

    public Question(string prompt, string answer, string language, string difficulty, string author, int votes, int views, double rating, int questionNumber)
    {
        Prompt = prompt;
        Answer = answer;
        Language = language;
        Difficulty = difficulty;
        Author = author;
        Votes = votes;
        Views = views;
        Rating = rating;
        QuestionNumber = questionNumber;
    }
}
