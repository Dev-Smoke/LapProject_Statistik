using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;

namespace LapProject
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        protected void Application_AuthenticateRequest(Object o, EventArgs eventArgs)
        {
            //1. Cookie auslesen
            var cookie = Request.Cookies.Get(FormsAuthentication.FormsCookieName);

            //Wenn Cookie oder Inhalt nicht vorhanden sind, abbruch
            if (cookie == null || string.IsNullOrWhiteSpace(cookie.Value)) return;
            //Ansonsten...
            //2. Ticket aus Cookie nehmen
            var encryptedTicket = cookie.Value;

            //3. Ticket entschlüsseln
            var authTicket = FormsAuthentication.Decrypt(encryptedTicket);

            //4. Benutzer als "angemeldet" markieren

            var userIdentity = new GenericIdentity(authTicket.Name);

            HttpContext.Current.User = new GenericPrincipal(userIdentity, null);
        }
    }
}
