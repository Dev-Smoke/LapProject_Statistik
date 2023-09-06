CREATE VIEW [dbo].Top5
AS
SELECT        TOP (5) dbo.Product.Name, SUM(dbo.OrderLine.Amount) AS Anzahl
FROM            dbo.OrderLine INNER JOIN
                         dbo.Product ON dbo.OrderLine.ProductId = dbo.Product.Id
GROUP BY dbo.Product.Name
ORDER BY Anzahl DESC








ALTER TABLE [Order]
ADD Discount decimal(28,2) not null default(0)
GO

ALTER TABLE [Order]
ADD PriceToPay decimal(28,2) not null default(0)
GO

ALTER TABLE OrderLine
ADD Discount decimal(28,2) not null default(0)
GO

--zur sicherheit, anpassen der alten datensätze
UPDATE [Order]
SET PriceToPay = PriceTotal
GO