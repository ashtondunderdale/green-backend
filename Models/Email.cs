namespace green_backend.Models
{
    public class Email
    {
        public string? EmailAddress { get; set; }

        public Email(string emailAddress) 
        { 
            EmailAddress = emailAddress;
        }
    }
}
