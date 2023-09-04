using LapProject.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;

namespace LapProject.Services
{
    public static class AccountService
    {
        public static Customer GetCustomer(string email)
        {
            using (var db = new LapWebshopEntities())
            {
                return db.Customers
                    .Where(cu => cu.Email.ToLower() == email.ToLower())
                    .First();
            }
        }

        public static int GetCustomerId(string email)
        {
            using(var db = new LapWebshopEntities())
            {
                var customerId = db.Customers
                    .Where(cu => cu.Email.ToLower() == email.ToLower())
                    .Select(cu => cu.Id)
                    .First();

                return customerId;
            }
        }
        public static bool Register(Customer customer, string password)
        {
            using (var db = new LapWebshopEntities())
            {
                var dbCustomer = db.Customers
                    .Where(c => c.Email.ToLower() == customer.Email.ToLower())
                    .FirstOrDefault();

                //1. Überprüfen ob Benutzer einzigartig
                if (dbCustomer != null) return false;

                //Da Benutzer nicht einzigartig...

                //2. Passwort salten

                //2a.: Salt erzeugen
                var salt = GenerateSalt(256);

                //2b.: Salt an Passwort hängen
                var saltedPw = SaltString(password, salt);

                //3. Passwort hashen
                var hashedPw = GetHash(saltedPw);

                //4. Benutzer in Db speichern

                customer.PwHash = hashedPw;
                customer.Salt = salt;

                db.Customers.Add(customer);
                db.SaveChanges();

                //Wenn Benutzer erfolgreich erzeugt, wird auch gleich ein Warenkorb angelegt
                CartService.CreateNewCart(customer.Email);

                return true;
            }
        }

        public static bool CanLogin(string email, string password)
        {
            using (var db = new LapWebshopEntities())
            {
                //1. Benutzerdaten Laden
                var dbCustomer = db.Customers
                    .Where(c => c.Email.ToLower() == email.ToLower())
                    .FirstOrDefault();

                //2. Wenn Benutzer nicht existiert kann er sich nicht anmelden
                if (dbCustomer == null) return false;

                //3. Wenn Benutzer existiert

                //4. Login-Passwort mit Salt aus Datenbank salten
                var saltedPw = SaltString(password, dbCustomer.Salt);

                //5. Gesaltetes Login-Passwort Hashen
                var hashedPw = GetHash(saltedPw);

                //6.
                return hashedPw.SequenceEqual(dbCustomer.PwHash);
            }
        }

        private static byte[] SaltString(string stringToSalt, byte[] salt)
        {
            //2b1.: Passwort-String in Bytes konvertieren
            var passwordBytes = System.Text.Encoding.UTF8.GetBytes(stringToSalt);

            //2b2.: Salt an Passwort anhängen
            var saltedPw = passwordBytes.Concat(salt).ToArray();

            return saltedPw;
        }

        private static byte[] GenerateSalt(int numBits)
        {
            byte[] saltBytes = new byte[numBits/8];

            var rng = new RNGCryptoServiceProvider();

            rng.GetNonZeroBytes(saltBytes);

            return saltBytes;
        }

        private static byte[] GetHash(byte[] input)
        {
            var hasher = new SHA256Managed();
            return hasher.ComputeHash(input);
        }
    }
}