using LapProject.Data;
using LapProject.Models.Chart;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LapProject.Controllers
{
    public class ChartsController : Controller
    {
        // GET: Charts Only
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ChartTop5()
        {
            using (LapWebshopEntities db = new LapWebshopEntities())
            {
                string[] labels = new string[db.Top5.Count()];

                int[] anzahl = new int[db.Top5.Count()];

                int i = 0;

                foreach (var eintrag in db.Top5)
                {
                    labels[i] = eintrag.Name;
                    anzahl[i] = eintrag.Anzahl ?? -1; 
                    i++;
                }

                var chartDaten = new ChartVM
                {
                    Anzahl = anzahl,

                    Namen = labels 
                };

                return View(chartDaten);

            }

        }

        public ActionResult ChartVerkauftProMonat()
        {
            using (var db = new LapWebshopEntities())
            {
                var salesData = db.Database.SqlQuery<SalesReport>(
                    @"SELECT
                YEAR(o.DateOrdered) AS Year,
                MONTH(o.DateOrdered) AS Month,
                SUM(ol.Amount) AS TotalSold
              FROM
                [Order] o
              JOIN
                OrderLine ol ON o.Id = ol.OrderId
              WHERE
                o.DateOrdered IS NOT NULL
              GROUP BY
                YEAR(o.DateOrdered),
                MONTH(o.DateOrdered)").ToList();

                // Optional: Transformieren Sie die Daten für die Chart.js-Verarbeitung
                var labels = salesData.Select(x => $"{x.Month}/{x.Year}").ToArray();
                var data = salesData.Select(x => x.TotalSold).ToArray();

                var chartData = new SaleReportVM
                {
                    Labels = labels,
                    Data = data
                };

                return View(chartData);
            }
        }
        public ActionResult ChartVerkaufteProdukte()
        {
            using (var db = new LapWebshopEntities())
            {
                var salesData = db.Database.SqlQuery<ProductSalesReport>(
                    @"SELECT
                YEAR(o.DateOrdered) AS Year,
                MONTH(o.DateOrdered) AS Month,
                p.Name AS ProductName,
                SUM(ol.Amount) AS TotalSold
              FROM
                [Order] o
              JOIN
                OrderLine ol ON o.Id = ol.OrderId
              JOIN
                Product p ON ol.ProductId = p.Id
              WHERE
                o.DateOrdered IS NOT NULL
              GROUP BY
                YEAR(o.DateOrdered),
                MONTH(o.DateOrdered),
                p.Name
              ORDER BY
                YEAR(o.DateOrdered),
                MONTH(o.DateOrdered),
                p.Name").ToList();
                var labels = salesData.Select(x => $"{x.ProductName} ({x.Month}/{x.Year})").ToArray();
                var data = salesData.Select(x => x.TotalSold).ToList();

                var chartData = new ProductSaleReportVM
                {
                    Labels = labels,
                    Data = data
                };

                return View(chartData);
            }
        }


    }


}

//public ActionResult ChartVerkauftProMonat()
//{
//    #region View alternative
//    //db.Database.SqlQuery<SalesReport>(
//    //      @"SELECT
//    //  YEAR(o.DateOrdered) AS Year,
//    //  MONTH(o.DateOrdered) AS Month,
//    //  SUM(ol.Amount) AS TotalSold
//    //FROM
//    //  [Order] o
//    //JOIN
//    //  OrderLine ol ON o.Id = ol.OrderId
//    //WHERE
//    //  o.DateOrdered IS NOT NULL
//    //GROUP BY
//    //  YEAR(o.DateOrdered),
//    //  MONTH(o.DateOrdered)
//    //ORDER BY
//    //  YEAR(o.DateOrdered),
//    //  MONTH(o.DateOrdered)").ToList(); 
//    #endregion
//    using (LapWebshopEntities db = new LapWebshopEntities())
//    {
//        var queryResult = db.AnzahlVerkaufteProdukteProMonats; // Stellen Sie sicher, dass der Datentyp korrekt ist

//        string[] labels = queryResult.Select(x => x.Month.ToString() + "/" + x.Year.ToString()).ToArray();
//        int[] data = queryResult.Select(x => x.TotalSold ?? -1).ToArray();

//        var chartData = new
//        {
//            Labels = labels,
//            Data = data
//        };

//        return View(chartData);
//    }
//}