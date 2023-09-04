using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using LapProject.Data;
using LapProject.Models.Account;
using LapProject.Services;


namespace LapProject.Controllers
{
    public class AccountController : BaseController
    {
        [HttpGet]
        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Register(RegisterVm vm)
        {
            //1.: Model validieren (Alle Daten vorhanden?)

            //2.: AGBs akzeptiert?

            //3.: Via Service Benutzer in Db speichern
            //Daten von Viewmodel in Entitätsmodel mappen

            var newCustomer = new Customer();
            newCustomer.Title = vm.Title;
            newCustomer.FirstName = vm.FirstName;
            newCustomer.LastName = vm.LastName;
            newCustomer.Street = vm.Street;
            newCustomer.ZipCode = vm.ZipCode;
            newCustomer.City = vm.City;

            newCustomer.Email = vm.Email;

            AccountService.Register(newCustomer, vm.Password);

            return RedirectToAction("Login");
        }

        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(string email, string password, string returnUrl)
        {
            //1. Prüfen ob sich Benutzer anmelden darf
            var canLogin = AccountService.CanLogin(email, password);

            if (!canLogin) return RedirectToAction("Login");

            //2. Wenn ja, Cookie mit Login-Ticket geben
            AuthenticateUser(email);

            return SafeRedirect(returnUrl);
        }

        [HttpGet]
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Home");
        }

        [NonAction]
        private void AuthenticateUser(string email)
        {
            var now = DateTime.Now;

            //1. Ticket erzeugen
            var ticket = new FormsAuthenticationTicket(
                0,                  //Versionsnummer des Tickets (für uns egal)
                email,              //(Einzigeratiger) Name
                now,                //Zeitpunkt der Ausstellung
                now.AddMinutes(30), //Zeitpunkt ab dem das Ticket ungültig ist
                true,               //Angemeldet bleiben?
                ""                  //Platz für beliebige Informationen            
                );

            //2. Ticket verschlüsseln
            var encryptedTicket = FormsAuthentication.Encrypt(ticket);

            //3. Ticket in ein Cookie legen
            var cookie = new HttpCookie(
                FormsAuthentication.FormsCookieName,
                encryptedTicket
                );

            //4. Cookie dem Benutzer geben
            Response.Cookies.Add(cookie);
        }
    }
}