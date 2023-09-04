using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using LapProject.Extensions;

namespace LapProject.Data
{
    public partial class OrderLine
    {
        public decimal GrossUnitPrice { get { return NetUnitPrice.GetGrossPrice(TaxRate); } }
        public decimal GrossLinePrice { get { return GrossUnitPrice * Amount; } }

        public decimal GrossDiscountedLinePrice { get { return (GrossUnitPrice - Discount) * Amount; } }

        public void ApplyVolumeDiscount()
        {
            if(Amount >= 10)
            {
                //discount: 15%
                Discount = NetUnitPrice * 0.15m;

            }
            else if (Amount >= 5)
            {
                //discount: 10%
                Discount = NetUnitPrice * 0.1m;
            }
            else
            {
                Discount = 0;
            }
        }
    }
}