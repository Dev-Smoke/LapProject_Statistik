using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapProject.Models.Chart
{
    public class ProductSaleReportVM
    {
        public string[] Labels { get; set; }
        public List<int> Data { get; set; }
    }
}