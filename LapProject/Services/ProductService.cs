using LapProject.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;

namespace LapProject.Services
{
    public static class ProductService
    {

        public static ProductFull GetProduct(int productId)
        {
            using (var db = new LapWebshopEntities())
            {
                return db.ProductFulls.Where(pf => pf.ProductId == productId).First();
            }
        }

        public static IEnumerable<ProductFull> GetAllProducts()
        {
            using (var db = new LapWebshopEntities())
            {
                return db.ProductFulls.ToList();
            }
        }

        public static IEnumerable<ProductFull> GetAllProducts(string searchQry, int? catId, int? manId)
        {
            if (string.IsNullOrWhiteSpace(searchQry)
                && catId is null
                && manId is null)
                return GetAllProducts();

            using (var db = new LapWebshopEntities())
            {
                var qry = db.ProductFulls.Select(p => p);

                if (!string.IsNullOrWhiteSpace(searchQry))
                {
                    searchQry = searchQry.ToLower();
                    qry = qry
                        .Where(pf => 
                                pf.ProductName.ToLower().Contains(searchQry)
                            ||  pf.Description.ToLower().Contains(searchQry)
                        );
                }

                if (!(catId is null)) qry = qry.Where(pf => pf.CategoryId == catId.Value);

                if (!(manId is null)) qry = qry.Where(pf => pf.ManufacturerId == manId.Value);

                return qry.ToList();
            }
        }

        public static Dictionary<int, string> GetCategoryDropdownDictionary()
        {
            using (var db = new LapWebshopEntities())
            {
                var categoryData = db.Categories.Select(c => new { c.Id, c.Name }).ToList();
                return categoryData.ToDictionary(d => d.Id, d => d.Name);
            }
        }

        public static Dictionary<int, string> GetManufacturerDropdownDictionary()
        {
            using (var db = new LapWebshopEntities())
            {
                var manufacturerData = db.Manufacturers.Select(c => new { c.Id, c.Name }).ToList();
                return manufacturerData.ToDictionary(d => d.Id, d => d.Name);
            }
        }
    }
}