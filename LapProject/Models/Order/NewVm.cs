using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapProject.Models.Order
{
    public class NewVm
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Street { get; set; }
        public string ZipCode { get; set; }
        public string City { get; set; }
        public IList<NewVmOrderLine> OrderLines { get; set; }
        public string TotalPrice { get; set; }
        public string PriceToPay { get; set; }
        public string OrderDiscount { get; set; }
        public string TotalProductDiscount { get; set; }

        public NewVm()
        {
            OrderLines = new List<NewVmOrderLine>();
        }
    }
}