using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapProject.Models.Order
{
    public class CompleteVm
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Street { get; set; }
        public string ZipCode { get; set; }
        public string City { get; set; }
    }
}