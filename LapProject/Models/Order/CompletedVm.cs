﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapProject.Models.Order
{
    public class CompletedVm
    {
        public int OrderId { get; set; }
        public string TotalPrice { get; set; }

        public string PriceToPay { get; set; }
    }
}