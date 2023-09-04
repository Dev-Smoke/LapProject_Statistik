using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using LapProject.Extensions;

namespace LapProject.Data
{
    public partial class Order
    {
        public bool IsCart { get { return DateOrdered is null; } }
        public bool IsOrder { get { return !IsCart; } }
        public void AddProduct(ProductFull product, int quantity)
        {
            if (IsOrder) throw new InvalidOperationException("Cannot add a product to an order");
            if (quantity <= 0) throw new ArgumentOutOfRangeException(nameof(quantity),"Quantity must be a positive number");

            var orderLine = GetOrderLineByProductId(product.ProductId);

            if (!(orderLine is null))
            {
                orderLine.Amount += quantity;
                orderLine.ApplyVolumeDiscount();
                return;
            }

            var newOrderLine = new OrderLine
            {
                OrderId = Id,
                ProductId = product.ProductId,
                Amount = quantity,
                NetUnitPrice = product.NetUnitPrice,
                TaxRate = product.TaxRate
            };
            newOrderLine.ApplyVolumeDiscount();

            OrderLines.Add(newOrderLine);
        }

        public void SetProductQuantity(int productId, int quantity)
        {
            if (IsOrder) throw new InvalidOperationException("Cannot change quantity of an order");

            if (quantity <= 0) throw new ArgumentOutOfRangeException(nameof(quantity), "Quantity must be a positive number");

            var orderLine = GetOrderLineByProductId(productId);

            if (orderLine is null) throw new InvalidOperationException("The specified product is not in the cart");

            orderLine.Amount = quantity;

            orderLine.ApplyVolumeDiscount();
        }

        public void RemoveProduct(int productId)
        {
            if (IsOrder) throw new InvalidOperationException("Cannot remove a product from an order");
            
            var orderLine = GetOrderLineByProductId(productId);

            if (orderLine is null) throw new InvalidOperationException("The specified product is not in the cart");

            OrderLines.Remove(orderLine);
        }

        public OrderLine GetOrderLineByProductId(int productId)
        {
            return OrderLines.Where(ol => ol.ProductId == productId).FirstOrDefault();
        }

        public void Complete()
        {
            if (IsOrder) throw new InvalidOperationException("Cannot complete an already completed order");

            PriceTotal = GrossTotalPrice;
            PriceToPay = DiscountedGrossTotalPrice;

            DateOrdered = DateTimeOffset.Now;
        }
        public void UpdateAddress(string firstName, string lastName, string street, string zipCode, string city)
        {
            FirstName = firstName;
            LastName = lastName;
            Street = street;
            ZipCode = zipCode;
            City = city;
        }
        public decimal GrossTotalPrice { get { return OrderLines.Sum(ol => ol.GrossLinePrice); } }

        public decimal DiscountedGrossTotalPrice => GrossTotalPrice - TotalProductDiscount - Discount;

        public decimal TotalProductDiscount { get { return OrderLines.Sum(ol => ol.Discount * ol.Amount); } }

    }
}