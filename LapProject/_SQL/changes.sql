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