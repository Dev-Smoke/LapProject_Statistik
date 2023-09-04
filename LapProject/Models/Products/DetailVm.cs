using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapProject.Models.Products
{
    public class DetailVm
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public string CategoryName { get; set; }
        public string ManufacturerName { get; set; }
        public string ProductPrice { get; set; }
        public string ProductDescription { get; set; }
        public string ProductImagePath { get; set; }
    }
}