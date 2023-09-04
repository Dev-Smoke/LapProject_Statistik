using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapProject.Models.Account
{
    public class RegisterVm
    {
        public string Title { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Street { get; set; }
        public string ZipCode { get; set; }
        public string City { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string PasswordCheck { get; set; }
        public string AcceptedTos { get; set; }
        public bool HasAcceptedTos
        {
            get
            {
                if (AcceptedTos != null && AcceptedTos.ToLower() == "on")
                {
                    return true;
                }
                else return false;
            }
        }
    }
}