using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapProject.Models.Cart
{
    public class IndexVmOrderLine
    {
        public int ProductId;
        public string Name;
        public string Manufacturer;
        public string GrossUnitPrice;
        public int Quantity;
        public string GrossLinePrice;
        public string GrossDiscountedLinePrice;
        public string UnitPriceDiscount;
        public string ImagePath;
    }
}