using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using LapProject.Extensions;
using LapProject.Services;
using LapProject.Models.Order;
using System.Web.Mvc;

namespace LapProject.Controllers
{
    [Authorize]
    public class OrderController : BaseController
    {
        [HttpGet]
        public ActionResult New()
        {
            CartService.ApplyFirstOrderDiscount(CustomerEmail);
            var dbCart = CartService.GetCartWithContent(CustomerEmail);

            var vm = new NewVm
            {
                TotalPrice = dbCart.GrossTotalPrice.ToEuroString(),
                FirstName = dbCart.FirstName,
                LastName = dbCart.LastName,
                Street = dbCart.Street,
                ZipCode = dbCart.ZipCode,
                City = dbCart.City,
                OrderDiscount = dbCart.Discount.ToEuroString(),
                TotalProductDiscount = dbCart.TotalProductDiscount.ToEuroString(),
                PriceToPay = dbCart.DiscountedGrossTotalPrice.ToEuroString()
            };

            foreach (var orderLine in dbCart.OrderLines)
            {
                var product = ProductService.GetProduct(orderLine.ProductId);
                var vmOrderLine = new NewVmOrderLine
                {
                    ProductId = product.ProductId,
                    Name = product.ProductName,
                    Manufacturer = product.ManufacturerName,
                    GrossLinePrice = orderLine.GrossLinePrice.ToEuroString(),
                    GrossUnitPrice = orderLine.GrossUnitPrice.ToEuroString(),
                    DiscountedLinePrice = orderLine.GrossDiscountedLinePrice.ToEuroString(),
                    Quantity = orderLine.Amount
                };

                vm.OrderLines.Add(vmOrderLine);
            }

            return View(vm);
        }

        [HttpPost]
        public ActionResult Complete(CompleteVm vm)
        {
            var orderId = CartService.OrderCart(CustomerEmail, vm.FirstName,vm.LastName,vm.Street,vm.ZipCode,vm.City);

            return RedirectToAction(nameof(Completed), new { id = orderId });
        }

        [HttpGet]
        public ActionResult Completed(int id)
        {
            var order = OrderService.GetCustomerOrder(CustomerEmail,id);

            var vm = new CompletedVm
            {
                OrderId = order.Id,
                TotalPrice = order.PriceTotal.ToEuroString(),
                PriceToPay = order.PriceToPay.ToEuroString()
            };

            return View(nameof(Completed),vm);
        }
    }
}