using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using LapProject.Data;

namespace LapProject.Services
{
    public static class OrderService
    {
        public static Order GetCustomerOrder(string email, int orderId)
        {
            using (var db = new LapWebshopEntities())
            {
                var order = db.Orders.Where(o => o.Id == orderId).First();
                var customerId = AccountService.GetCustomerId(email);
                if (order.IsCart) throw new ArgumentException(nameof(orderId), "Supplied OrderId does not reference an Order");
                if (order.CustomerId != customerId) throw new InvalidOperationException("The order does not belong to this customer!");
                return order;
            }
        }
    }
}