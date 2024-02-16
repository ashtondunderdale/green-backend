namespace green_backend.Models
{
    public class PreLaunchUser
    {
        public string? EmailAddress { get; set; }

        public string? Name { get; set; }

        public string? TimeStamp { get; set; }

        public PreLaunchUser(string emailAddress, string name, string timeStamp) 
        { 
            EmailAddress = emailAddress;
            Name = name;
            TimeStamp = timeStamp;
        }
    }
}
