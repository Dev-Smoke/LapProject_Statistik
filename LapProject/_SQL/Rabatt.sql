--Für Rabatte von einzelnen Produkten
ALTER TABLE Orderline
ADD Discount decimal(6,2) null

--Diesesfür Rabatt auf die gesamte Bestellung
ALTER TABLE [Order]
ADD Discount decimal(6,2) null

--Hier wird der Rabttierte Gesamtpreis gespeichert
ALTER TABLE [Order]
ADD PriceToPay decimal(6,2) null

UPDATE [Order]
SET PriceToPay = 0 -- Setzen Sie hier den Wert, den Sie als Standardwert haben möchten
WHERE PriceToPay IS NULL
ALTER TABLE [Order]
ALTER COLUMN PriceToPay decimal(10,2) NOT NULL

UPDATE [Order]
SET Discount = 0 -- Setzen Sie hier den Wert, den Sie als Standardwert haben möchten
WHERE Discount IS NULL
ALTER TABLE [Order]
ALTER COLUMN Discount decimal(10,2) NOT NULL

UPDATE Orderline
SET Discount = 0 -- Setzen Sie hier den Wert, den Sie als Standardwert haben möchten
WHERE Discount IS NULL
ALTER TABLE Orderline
ALTER COLUMN Discount decimal(10,2) NOT NULL

--Chart
CREATE OR ALTER VIEW [dbo].[ProductsOfTheMonthView] AS
SELECT TOP 10
    pf.ProductId,
    pf.ProductName,
    pf.ManufacturerName,
    pf.CategoryName,
    pf.TaxRate,
    SUM(ol.Amount) AS TotalAmountSold
FROM [dbo].[ProductFull] pf
JOIN [dbo].[OrderLine] ol ON pf.ProductId = ol.ProductId
JOIN [dbo].[Order] o ON o.Id = ol.OrderId
WHERE DATEPART(YEAR, o.DateOrdered) = 2020 AND DATEPART(MONTH, o.DateOrdered) = 10
GROUP BY pf.ProductId, pf.ProductName, pf.ManufacturerName, pf.CategoryName, pf.TaxRate
ORDER BY TotalAmountSold DESC;