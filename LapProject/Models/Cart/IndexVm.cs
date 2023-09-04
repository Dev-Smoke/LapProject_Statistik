using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapProject.Models.Cart
{
    public class IndexVm
    {
        public IList<IndexVmOrderLine> OrderLines { get; set; }
        public string TotalPrice { get; set; }

        public string OrderDiscountAmount { get; set; }
        public string ProductDiscountAmount { get; set; }
        public string PriceToPay { get; set; }

        public IndexVm()
        {
            OrderLines = new List<IndexVmOrderLine>();
        }
    }
}