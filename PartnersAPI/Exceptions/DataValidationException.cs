namespace PartnersAPI.Exceptions
{
    class DataValidationException : Exception
    {
        public DataValidationException(string message) : base(message)
        {
        }
    }
}