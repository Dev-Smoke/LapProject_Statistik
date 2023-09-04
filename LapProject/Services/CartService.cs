using LapProject.Data;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Security.Cryptography;
using System.Web;

namespace LapProject.Services
{
    public static class CartService
    {
        public static void CreateNewCart(string email)
        {
            if (GetCartId(email) != null) throw new InvalidOperationException("Customer already has a cart");

            var customer = AccountService.GetCustomer(email);

            var cart = new Order()
            {
                CustomerId = customer.Id,
                FirstName = customer.FirstName,
                LastName = customer.LastName,
                Street = customer.Street,
                ZipCode = customer.ZipCode,
                City = customer.City,
                DateOrdered = null,
                DatePaid = null,
                PriceTotal = 0
            };

            using (var db = new LapWebshopEntities())
            {
                db.Orders.Add(cart);
                db.SaveChanges();
            }
        }

        public static void ApplyFirstOrderDiscount(string email)
        {
            using (var db = new LapWebshopEntities())
            {
                //Bestellung abrufen
                //Prüfen ob Rabatt gewährt werden soll
                //Wenn ja, dann 10 € eintragen
                //Wenn nein, dann 0 € eintragen
                //Und abspeichern

                var userOrders = db.Orders.Where(o => o.Customer.Email.ToLower() == email.ToLower()).ToList();
                if (userOrders.Count == 1)
                {
                    if (userOrders.First().GrossTotalPrice >= 50)
                    {
                        userOrders.First().Discount = 10;
                    }
                    else
                    {
                        userOrders.First().Discount = 0;
                    }
                }
                db.SaveChanges();
            }
        }

        public static void AddToCart(string email, int productId, int quantity)
        {
            var product = ProductService.GetProduct(productId);

            var cart = GetCartWithContent(email);

            using (var db = new LapWebshopEntities())
            {
                db.Orders.Attach(cart);

                cart.AddProduct(product, quantity);


                db.SaveChanges();
            }
        }

        private static int? GetCartId(string email)
        {
            var customerId = AccountService.GetCustomerId(email);

            using (var db = new LapWebshopEntities())
            {
                try
                {
                    return db.Orders
                        .Where(o => o.CustomerId == customerId)
                        .Where(o => o.DateOrdered == null)
                        .Select(o => o.Id)
                        .First();
                }
                catch (Exception) { return null; }
            }
        }

        public static int OrderCart(string email, string firstName, string lastName, string street, string zipCode, string city)
        {
            var cart = GetCart(email);

            using (var db = new LapWebshopEntities())
            {
                db.Orders.Attach(cart);

                cart.UpdateAddress(firstName, lastName, street, zipCode, city);

                cart.Complete();

                db.SaveChanges();
            }

            CreateNewCart(email);

            return cart.Id;
        }

        public static void ChangeQuantity(string email, int productId, int quantity)
        {
            var cart = GetCartWithContent(email);

            using (var db = new LapWebshopEntities())
            {
                db.Orders.Attach(cart);

                cart.SetProductQuantity(productId, quantity);

                db.SaveChanges();
            }
        }

        public static void RemoveFromCart(string email, int productId)
        {
            var cart = GetCartWithContent(email);

            using (var db = new LapWebshopEntities())
            {
                db.Orders.Attach(cart);


                //If we do not delete the OrderLine manually, EF will try to set the FK to null instead of deleting the OrderLine
                var orderLine = cart.GetOrderLineByProductId(productId);

                //This is, in theory, not even necessary 
                cart.RemoveProduct(productId);

                db.Entry(orderLine).State = EntityState.Deleted;

                //var numProductsInOrder = db.OrderLines.Where(ol => ol.OrderId == cart.Id).Count();
                if(!cart.OrderLines.Any())
                {
                    cart.Discount = 0;
                }

                db.SaveChanges();
            }
        }

        private static Order GetCart(string email)
        {
            var cartId = GetCartId(email);

            using (var db = new LapWebshopEntities())
            {
                return db.Orders
                    .Where(o => o.Id == cartId)
                    .First();
            }
        }

        public static Order GetCartWithContent(string email)
        {
            var cartId = GetCartId(email);

            using (var db = new LapWebshopEntities())
            {
                return db.Orders
                    .Include(o => o.OrderLines)
                    .Where(o => o.Id == cartId)
                    .First();
            }
        }
    }
}