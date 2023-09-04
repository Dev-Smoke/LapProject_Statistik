using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapProject.Extensions
{
    public static class DecimalExtensions
    {
        public static string ToEuroString(this decimal num) => $"{num.ToString("N2")} €";
        public static decimal TruncateThousandths(this decimal num)
        {
            return (int)(num * 100m) / 100m;
        }
        public static decimal GetGrossPrice(this decimal netPrice, decimal taxRate)
        {
            return (netPrice * ((100m + taxRate) / 100m)).TruncateThousandths();
        }
    }
}