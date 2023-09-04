using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using LapProject.Extensions;
using LapProject.Services;
using LapProject.Models.Cart;
using System.Web.Mvc;

namespace LapProject.Controllers
{
    [Authorize]
    public class CartController : BaseController
    {
        [HttpGet]
        public ActionResult Index()
        {
            var dbCart = CartService.GetCartWithContent(CustomerEmail);

            var vm = new IndexVm
            {
                TotalPrice = dbCart.GrossTotalPrice.ToEuroString(),
                PriceToPay = dbCart.DiscountedGrossTotalPrice.ToEuroString(),
                OrderDiscountAmount = dbCart.Discount.ToEuroString(),
                ProductDiscountAmount = dbCart.TotalProductDiscount.ToEuroString() //Summe Rabatte Einzelprodukte
            };

            foreach (var orderLine in dbCart.OrderLines)
            {
                var product = ProductService.GetProduct(orderLine.ProductId);
                var vmOrderLine = new IndexVmOrderLine
                {
                    ProductId = product.ProductId,
                    Name = product.ProductName,
                    Manufacturer = product.ManufacturerName,
                    ImagePath = product.ImagePath,
                    GrossLinePrice = orderLine.GrossLinePrice.ToEuroString(),
                    GrossUnitPrice = orderLine.GrossUnitPrice.ToEuroString(),
                    Quantity = orderLine.Amount,
                    GrossDiscountedLinePrice = orderLine.GrossDiscountedLinePrice.ToEuroString(),
                    UnitPriceDiscount = orderLine.Discount.ToEuroString()
                };

                vm.OrderLines.Add(vmOrderLine);
            }

            return View(vm);
        }

        [HttpPost]
        public ActionResult Add(int productId, int? quantity = 1, string returnUrl = "")
        {
            CartService.AddToCart(CustomerEmail, productId, quantity.Value);

            return SafeRedirect(returnUrl);
        }

        [HttpPost]
        public ActionResult Remove(int productId)
        {
            CartService.RemoveFromCart(CustomerEmail, productId);

            return RedirectToAction(nameof(Index));
        }

        [HttpPost]
        public ActionResult ChangeQuantity(int productId, int quantity)
        {
            CartService.ChangeQuantity(CustomerEmail, productId, quantity);

            return RedirectToAction(nameof(Index));
        }

    }
}