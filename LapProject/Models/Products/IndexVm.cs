using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LapProject.Models.Products
{
    public class IndexVm
    {
        public string Search { get; set; }
        public int? CatId { get; set; }
        public int? ManId { get; set; }

        public Dictionary<int, string> CategoryDropdownData { get; set; }
        public Dictionary<int, string> ManufacturerDropdownData { get; set; }

        public IList<IndexVmProduct> Products { get; set; }
        public IndexVm()
        {
            Products = new List<IndexVmProduct>();
        }
        public bool IsCatSelected(int? catId) => CatId == catId;
        public bool IsManSelected(int? manId) => ManId == manId;
    }
}