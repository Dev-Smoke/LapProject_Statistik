using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapProject.Models.Order
{
    public class NewVmOrderLine
    {
        public int ProductId;
        public string Name;
        public string Manufacturer;
        public string GrossUnitPrice;
        public int Quantity;
        public string GrossLinePrice;
        public string DiscountedLinePrice;
    }
}