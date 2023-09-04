using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LapProject.Models.Products;
using LapProject.Services;

namespace LapProject.Controllers
{
    public class ProductsController : BaseController
    {
        public ActionResult Index(string search, int? catId, int? manId)
        {
            var dbProducts = ProductService.GetAllProducts(search, catId, manId);

            var vm = new IndexVm()
            {
                Search = search,
                CatId = catId,
                ManId = manId,
                ManufacturerDropdownData = ProductService.GetManufacturerDropdownDictionary(),
                CategoryDropdownData = ProductService.GetCategoryDropdownDictionary()
            };

            foreach(var dbProduct in dbProducts)
            {
                var vmProduct = new IndexVmProduct
                {
                    Id = dbProduct.ProductId,
                    Name = dbProduct.ProductName,
                    Manufacturer = dbProduct.ManufacturerName,
                    Price = dbProduct.GrossUnitPriceString,
                    ImagePath = dbProduct.ImagePath
                };
                vm.Products.Add(vmProduct);
            }

            return View(vm);
        }

        public ActionResult Detail(int? id)
        {
            if (id is null) return RedirectToAction(nameof(Index));

            var dbProduct = ProductService.GetProduct(id.Value);

            var vm = new DetailVm()
            {
                ProductId = dbProduct.ProductId,
                ProductName = dbProduct.ProductName,
                ProductPrice = dbProduct.GrossUnitPriceString,
                ProductDescription = dbProduct.Description,
                ProductImagePath = dbProduct.ImagePath,
                CategoryName = dbProduct.CategoryName,
                ManufacturerName = dbProduct.ManufacturerName
            };

            return View(vm);
        }
    }
}