using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapProject.Models.Chart
{
    public class ProductSalesReport
    {
        public int Year { get; set; }
        public int Month { get; set; }
        public string ProductName { get; set; }
        public int TotalSold { get; set; }
    }
}