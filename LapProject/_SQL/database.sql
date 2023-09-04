USE [master]
CREATE DATABASE [LapWebshop]
GO

USE [LapWebshop]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 01.12.2020 20:52:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[TaxRate] [decimal](9, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manufacturer]    Script Date: 01.12.2020 20:52:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manufacturer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 01.12.2020 20:52:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[NetUnitPrice] [decimal](19, 2) NOT NULL,
	[ImagePath] [nvarchar](500) NULL,
	[Description] [nvarchar](max) NOT NULL,
	[ManufacturerId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[ProductFull]    Script Date: 01.12.2020 20:52:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProductFull]
AS
	SELECT
		pr.Id as ProductId,
		pr.Name as ProductName,
		pr.NetUnitPrice,
		pr.ImagePath,
		pr.Description,
		pr.ManufacturerId,
		pr.CategoryId,
		ma.Name as ManufacturerName,
		ca.Name as CategoryName,
		ca.TaxRate
	FROM Product pr
		JOIN Manufacturer ma ON ma.Id = pr.ManufacturerId
		JOIN Category ca ON ca.Id = pr.CategoryId
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 01.12.2020 20:52:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](150) NOT NULL,
	[LastName] [nvarchar](150) NOT NULL,
	[Email] [nvarchar](350) NOT NULL,
	[Street] [nvarchar](150) NOT NULL,
	[ZipCode] [nvarchar](50) NOT NULL,
	[City] [nvarchar](200) NOT NULL,
	[PwHash] [binary](32) NOT NULL,
	[Salt] [binary](32) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 01.12.2020 20:52:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[PriceTotal] [decimal](28, 2) NOT NULL,
	[DateOrdered] [datetimeoffset](7) NULL,
	[DatePaid] [datetimeoffset](7) NULL,
	[FirstName] [nvarchar](150) NOT NULL,
	[LastName] [nvarchar](150) NOT NULL,
	[Street] [nvarchar](150) NOT NULL,
	[ZipCode] [nvarchar](50) NOT NULL,
	[City] [nvarchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderLine]    Script Date: 01.12.2020 20:52:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderLine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Amount] [int] NOT NULL,
	[NetUnitPrice] [decimal](19, 2) NOT NULL,
	[TaxRate] [decimal](9, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 
GO
INSERT [dbo].[Category] ([Id], [Name], [TaxRate]) VALUES (1, N'Brettspiel', CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[Category] ([Id], [Name], [TaxRate]) VALUES (2, N'Kartenspiel', CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[Category] ([Id], [Name], [TaxRate]) VALUES (3, N'Videospiel', CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[Category] ([Id], [Name], [TaxRate]) VALUES (4, N'Pen & Paper', CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[Category] ([Id], [Name], [TaxRate]) VALUES (5, N'Konsole', CAST(20.00 AS Decimal(9, 2)))
GO
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 
GO
INSERT [dbo].[Customer] ([Id], [Title], [FirstName], [LastName], [Email], [Street], [ZipCode], [City], [PwHash], [Salt]) VALUES (1, N'Herr', N'Franz', N'Hauser', N'franz.hauser@fake.fake', N'Albertgasse 7/5', N'1080', N'Wien', 0x845FC9E7EEFD6A532CFE082D23E9525CB84F93B86D43766BD7C2CF962722BE55, 0x52D6BC4089E6F9419813299D34086A85CB1E415C9FCACDF80E7F496435AD098D)
GO
INSERT [dbo].[Customer] ([Id], [Title], [FirstName], [LastName], [Email], [Street], [ZipCode], [City], [PwHash], [Salt]) VALUES (2, N'Frau', N'Janine', N'Müller', N'janine.müller@fake.fake', N'Rabensburger Straße 15', N'1020', N'Wien', 0x30C6820E8E2D9C652CCDAC8C8E0814499C0FFB4F6435EE9F11233E21DFF47C45, 0xF7F45CEEEEC6D4E1D23FA66E560A774EB35E0E536FC4461369631D80BA3DA8C9)
GO
INSERT [dbo].[Customer] ([Id], [Title], [FirstName], [LastName], [Email], [Street], [ZipCode], [City], [PwHash], [Salt]) VALUES (3, N'Herr', N'Max', N'Schreiber', N'max.schreiber@fake.fake', N'Rochusgasse 12/4/2', N'1030', N'Wien', 0x7E121B83FE8A9628E83C07EB96EAA029A0E9CBA865EF09454B8A0C36FB39DD60, 0xF1F80ADFEB8CB77DFA3047CCF46D127B10DEBB8C6807755E815046F649B4ED8F)
GO
INSERT [dbo].[Customer] ([Id], [Title], [FirstName], [LastName], [Email], [Street], [ZipCode], [City], [PwHash], [Salt]) VALUES (4, N'Frau', N'Maria', N'Niedermayer', N'maria.niedermayer@fake.fake', N'Gerstlgasse 7/2/23', N'1210', N'Wien', 0xED488C8D7E297EC974DB081AC9BA263FF57DE2151482A4B81B425A8332E25180, 0x9680DFF5FEB193EBA75528807B11A4D2BAC2E35942F35435511903B4B41435B0)
GO
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Manufacturer] ON 
GO
INSERT [dbo].[Manufacturer] ([Id], [Name]) VALUES (1, N'Pegasus Spiele')
GO
INSERT [dbo].[Manufacturer] ([Id], [Name]) VALUES (2, N'KOSMOS')
GO
INSERT [dbo].[Manufacturer] ([Id], [Name]) VALUES (3, N'Wizards of the Coast')
GO
INSERT [dbo].[Manufacturer] ([Id], [Name]) VALUES (4, N'Nintendo')
GO
INSERT [dbo].[Manufacturer] ([Id], [Name]) VALUES (5, N'Sony')
GO
INSERT [dbo].[Manufacturer] ([Id], [Name]) VALUES (6, N'Microsoft')
GO
SET IDENTITY_INSERT [dbo].[Manufacturer] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (1, 1, CAST(56.96 AS Decimal(28, 2)), CAST(N'2020-10-05T20:35:59.0407073+01:00' AS DateTimeOffset), NULL, N'Franz', N'Hauser', N'Albertgasse 7/5', N'1080', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (2, 1, CAST(55.78 AS Decimal(28, 2)), CAST(N'2020-11-06T20:36:40.6503776+01:00' AS DateTimeOffset), NULL, N'Franz', N'Hauser', N'Albertgasse 7/5', N'1080', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (3, 1, CAST(67.96 AS Decimal(28, 2)), CAST(N'2020-11-09T20:37:03.2773451+01:00' AS DateTimeOffset), NULL, N'Franz', N'Hauser', N'Albertgasse 7/5', N'1080', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (4, 1, CAST(417.47 AS Decimal(28, 2)), CAST(N'2020-12-01T20:38:03.9717844+01:00' AS DateTimeOffset), NULL, N'Franz', N'Hauser', N'Albertgasse 7/5', N'1080', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (5, 1, CAST(0.00 AS Decimal(28, 2)), NULL, NULL, N'Franz', N'Hauser', N'Albertgasse 7/5', N'1080', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (6, 2, CAST(59.93 AS Decimal(28, 2)), CAST(N'2020-10-03T20:39:38.4346841+01:00' AS DateTimeOffset), NULL, N'Janine', N'Müller', N'Rabensburger Straße 15', N'1020', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (7, 2, CAST(99.99 AS Decimal(28, 2)), CAST(N'2020-10-18T20:39:53.4348469+01:00' AS DateTimeOffset), NULL, N'Janine', N'Müller', N'Rabensburger Straße 15', N'1020', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (8, 2, CAST(59.90 AS Decimal(28, 2)), CAST(N'2020-11-15T20:40:02.5464936+01:00' AS DateTimeOffset), NULL, N'Janine', N'Müller', N'Rabensburger Straße 15', N'1020', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (9, 2, CAST(17.76 AS Decimal(28, 2)), CAST(N'2020-11-30T20:40:14.7831458+01:00' AS DateTimeOffset), NULL, N'Janine', N'Müller', N'Rabensburger Straße 15', N'1020', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (10, 2, CAST(0.00 AS Decimal(28, 2)), NULL, NULL, N'Janine', N'Müller', N'Rabensburger Straße 15', N'1020', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (11, 3, CAST(417.47 AS Decimal(28, 2)), CAST(N'2020-10-04T20:41:34.5091229+01:00' AS DateTimeOffset), NULL, N'Max', N'Schreiber', N'Rochusgasse 12/4/2', N'1030', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (12, 3, CAST(43.89 AS Decimal(28, 2)), CAST(N'2020-10-09T20:41:48.1189989+01:00' AS DateTimeOffset), NULL, N'Max', N'Schreiber', N'Rochusgasse 12/4/2', N'1030', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (13, 3, CAST(46.99 AS Decimal(28, 2)), CAST(N'2020-10-18T20:42:03.7863638+01:00' AS DateTimeOffset), NULL, N'Max', N'Schreiber', N'Rochusgasse 12/4/2', N'1030', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (14, 3, CAST(129.94 AS Decimal(28, 2)), CAST(N'2020-10-29T20:42:14.8811572+01:00' AS DateTimeOffset), NULL, N'Max', N'Schreiber', N'Rochusgasse 12/4/2', N'1030', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (15, 3, CAST(47.98 AS Decimal(28, 2)), CAST(N'2020-11-17T20:42:26.8185194+01:00' AS DateTimeOffset), NULL, N'Max', N'Schreiber', N'Rochusgasse 12/4/2', N'1030', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (16, 3, CAST(28.15 AS Decimal(28, 2)), CAST(N'2020-11-25T20:42:40.5160331+01:00' AS DateTimeOffset), NULL, N'Max', N'Schreiber', N'Rochusgasse 12/4/2', N'1030', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (17, 3, CAST(16.99 AS Decimal(28, 2)), CAST(N'2020-12-01T20:43:35.5601161+01:00' AS DateTimeOffset), NULL, N'Max', N'Schreiber', N'Rochusgasse 12/4/2', N'1030', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (18, 3, CAST(0.00 AS Decimal(28, 2)), NULL, NULL, N'Max', N'Schreiber', N'Rochusgasse 12/4/2', N'1030', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (19, 4, CAST(39.94 AS Decimal(28, 2)), CAST(N'2020-10-01T20:45:05.8408502+01:00' AS DateTimeOffset), NULL, N'Maria', N'Niedermayer', N'Gerstlgasse 7/2/23', N'1210', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (20, 4, CAST(21.99 AS Decimal(28, 2)), CAST(N'2020-10-19T20:45:14.6411108+01:00' AS DateTimeOffset), NULL, N'Maria', N'Niedermayer', N'Gerstlgasse 7/2/23', N'1210', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (21, 4, CAST(108.97 AS Decimal(28, 2)), CAST(N'2020-11-03T20:45:27.1178303+01:00' AS DateTimeOffset), NULL, N'Maria', N'Niedermayer', N'Gerstlgasse 7/2/23', N'1210', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (22, 4, CAST(47.71 AS Decimal(28, 2)), CAST(N'2020-11-14T20:47:16.6116169+01:00' AS DateTimeOffset), NULL, N'Maria', N'Niedermayer', N'Gerstlgasse 7/2/23', N'1210', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (23, 4, CAST(33.98 AS Decimal(28, 2)), CAST(N'2020-11-22T20:47:32.9770836+01:00' AS DateTimeOffset), NULL, N'Maria', N'Niedermayer', N'Gerstlgasse 7/2/23', N'1210', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (24, 4, CAST(59.90 AS Decimal(28, 2)), CAST(N'2020-12-01T20:47:40.0721370+01:00' AS DateTimeOffset), NULL, N'Maria', N'Niedermayer', N'Gerstlgasse 7/2/23', N'1210', N'Wien')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [PriceTotal], [DateOrdered], [DatePaid], [FirstName], [LastName], [Street], [ZipCode], [City]) VALUES (25, 4, CAST(0.00 AS Decimal(28, 2)), NULL, NULL, N'Maria', N'Niedermayer', N'Gerstlgasse 7/2/23', N'1210', N'Wien')
GO
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderLine] ON 
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (1, 1, 2, 1, CAST(8.33 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (2, 1, 11, 1, CAST(24.99 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (3, 1, 10, 1, CAST(14.16 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (5, 2, 3, 1, CAST(20.83 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (6, 2, 7, 1, CAST(25.66 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (7, 3, 12, 1, CAST(14.16 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (8, 3, 13, 1, CAST(14.16 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (9, 3, 14, 1, CAST(14.16 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (10, 3, 15, 1, CAST(14.16 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (11, 4, 19, 1, CAST(262.49 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (12, 4, 30, 1, CAST(45.00 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (13, 4, 31, 1, CAST(40.41 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (14, 6, 11, 1, CAST(24.99 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (15, 6, 39, 1, CAST(24.96 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (16, 7, 40, 1, CAST(83.33 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (17, 8, 1, 2, CAST(24.96 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (18, 9, 43, 1, CAST(14.80 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (19, 11, 19, 1, CAST(262.49 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (20, 11, 30, 1, CAST(45.00 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (21, 11, 31, 1, CAST(40.41 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (22, 12, 34, 1, CAST(36.58 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (23, 13, 36, 1, CAST(39.16 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (24, 14, 1, 1, CAST(24.96 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (25, 14, 40, 1, CAST(83.33 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (26, 15, 18, 1, CAST(39.99 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (27, 16, 44, 1, CAST(8.66 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (28, 16, 43, 1, CAST(14.80 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (29, 17, 15, 1, CAST(14.16 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (30, 19, 2, 1, CAST(8.33 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (31, 19, 1, 1, CAST(24.96 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (32, 20, 38, 1, CAST(18.33 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (33, 21, 40, 1, CAST(83.33 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (34, 21, 42, 1, CAST(7.49 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (35, 22, 1, 1, CAST(24.96 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (36, 22, 43, 1, CAST(14.80 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (37, 23, 14, 1, CAST(14.16 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (38, 23, 15, 1, CAST(14.16 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[OrderLine] ([Id], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate]) VALUES (39, 24, 1, 2, CAST(24.96 AS Decimal(19, 2)), CAST(20.00 AS Decimal(9, 2)))
GO
SET IDENTITY_INSERT [dbo].[OrderLine] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (1, N'Junta', CAST(24.96 AS Decimal(19, 2)), N'/Content/Images/Products/junta.jpg', N'In der mittlerweile sagenumwobenen República de las Bananas herrscht eine korrupte Militärdiktatur, deren Mitglieder nur Geld und Macht interessieren. Ihre Mittel reichen in Junta, dem Brettspielklassiker, von Intrigen bis hin zur Revolution. Zu Beginn wird der Präsident "gewählt", der den (unbekannten) Haushalt vom Geldstapel zieht, dann seine 6 Kabinettsmitglieder ernennt und ihnen einen Teil seines Etats abgibt. Natürlich sind einige Minister mit ihrem Einkommen nicht zufrieden, und so wird schön intrigiert und schließlich, ist ja logisch, die Junta geprobt und der Präsident gestürzt! Der darf alles Geld, was er vor seinem Sturz auf ein Schweizer Nummernkonto überweisen konnte, behalten. Dann wird ein neuer Präsident gewählt, und das Spielchen beginnt aufs Neue. Gewinner ist natürlich der, der am Ende des Spiels die meisten Moneten auf seinem Schweizer Bankkonto angehäuft hat, wie das in Militärdiktaturen nun mal so Tradition ist! Das von schwarzem Humor nur so strotzende Brettspiel Junta ist seit über 30 Jahren ein Dauerbrenner, und wurde bei seiner Veröffentlichung in der New York Times und der Washington Post in den höchsten Tönen gelobt. Die Junta Neuauflage präsentiert den Klassiker in neuem Schachtelformat und mit neuem Spielmaterial. ', 1, 1)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (2, N'Die Crew', CAST(8.33 AS Decimal(19, 2)), N'/Content/Images/Products/crew.jpg', N'Im kooperativen Kartenspiel „Die Crew“ begeben sich die Spieler als Astronauten auf ein ungewisses Weltraum-Abenteuer. Was hat es mit den Gerüchten um den unbekannten Planeten auf sich?
Ihre ereignisreiche Reise durchs All erstreckt sich über 50 spannende Missionen. Doch dieses Spiel kann nur bezwungen werden, indem gemeinsam die individuellen Aufgaben jedes Spielers erfüllt werden. Um die abwechslungsreichen Herausforderungen meistern zu können, ist Kommunikation im Team unerlässlich. Doch das ist im Weltraum schwieriger als gedacht.', 2, 2)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (3, N'Dungeons & Dragons Starter Pack', CAST(20.83 AS Decimal(19, 2)), N'/Content/Images/Products/dndstarter.jpg', N'Explore subterranean labyrinths Plunder hoards of treasure Battle legendary monsters
 
The Dungeons & Dragons Starter Set is your gateway to action-packed stories of the imagination. This box contains the essential rules of the game plus everything you need to play heroic characters on perilous adventures in worlds of fantasy.
 
Ideal for a group of 4 – 6, the Dungeons & Dragons Starter Set includes a 64-page adventure book with everything the Dungeon Master needs to get started, a 32-page rulebook for playing characters level 1 – 5, 5 pregenerated characters, each with a character sheet and supporting reference material, and 6 dice. ', 3, 4)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (4, N'Dungeons & Dragons Essentials Kit', CAST(20.83 AS Decimal(19, 2)), N'/Content/Images/Products/dndessentials.jpg', N'Everything you need to create characters and play the new adventures in this introduction to the world&;s greatest roleplaying game. Designed for 2-6 players.', 3, 4)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (5, N'Dungeons & Dragons Core Rulebook Gift Set', CAST(106.66 AS Decimal(19, 2)), N'/Content/Images/Products/dndgiftset.jpg', N'The Dungeons & Dragons gift set includes a copy of all three core rulebooks and a Dungeon Master''s Screen, everything you need to create and play adventures of your own in the world''s greatest roleplaying game. ', 3, 4)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (6, N'D&D Dungeon Master''s Guide', CAST(34.99 AS Decimal(19, 2)), N'/Content/Images/Products/dndmasterguide.jpg', N'Der Dungeon Master Guide® (Spielleiterhandbuch) gibt dir Inspiration und Anleitung, um den Funken deiner Vorstellungskraft zu entfachen und Welten voller Abenteuer zu erschaffen, die deine Spieler erforschen können und begeistern werden. In diesem Band findest du Ratschläge, Hinweise zur Weltenschöpfung sowie Hinweise, um unvergessliche Verliese und Abenteuer zu erschaffen. Darüber hinaus enthält es optionale Spielregeln, Hunderte klassische magische Gegenstände und viele weitere Werkzeuge, die dir als Spielleiter sehr hilfreich sein werden. Wenn du bereit für mehr bist, dann erweitere deine Abenteuer mit der fünften Edition des Players Handbooks® (Spielerhandbuch) und dem Monster Manual® (Monsterhandbuch). 6. Auflage', 3, 4)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (7, N'D&D Sword Coast Adventurer''s Guide', CAST(25.66 AS Decimal(19, 2)), N'/Content/Images/Products/dndswordcoast.jpg', N'Get everything you need to adventure in the Forgotten Realms on the exciting Sword Coast, home to the cities of Baldur ''s Gate, Waterdeep, and Neverwinter. Crafted by the scribes at Green Ronin in conjunction with the Dungeons & Dragons team at Wizards of the Coast, the Sword Coast Adventurer ''s Guide provides D&D fans with a wealth of detail on the places, cultures, and deities of northwestern Faerûn.
 
The Sword Coast Adventurer ''s Guide is also a great way to catch up on recent events in the Forgotten Realms, to get background on locations featured in the Rage of Demons storyline coming in September, and to learn the lore behind video games like Neverwinter and Sword Coast Legends. ', 3, 4)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (8, N'D&D Player''s Handbook', CAST(34.99 AS Decimal(19, 2)), N'/Content/Images/Products/dndhandbook.jpg', N'
The Player ''s Handbook is the essential reference for every Dungeons & Dragons roleplayer. It contains rules for character creation and advancement, backgrounds and skills, exploration and combat, equipment, spells, and much more.
 
Use this book to create exciting characters from among the most iconic D&D races and classes.
 
Dungeons & Dragons immerses you in a world of adventure. Explore ancient ruins and deadly dungeons. Battle monsters while searching for legendary treasures. Gain experience and power as you trek across uncharted lands with your companions.
 
The world needs heroes. Will you answer the call?. ', 3, 4)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (9, N'My City', CAST(24.16 AS Decimal(19, 2)), N'/Content/Images/Products/mycity.jpg', N'Eine Stadt bauen, weiterentwickeln und zugleich auf Zeitreise gehen: Das Legespiel „My City“ sorgt von Spiel zu Spiel für spannende Wendungen.
Während der einzelnen Partien kommen immer wieder neue Regeln und Spielmaterialien für die zwei bis vier Spieler hinzu, bis nach 24 Spielen die abwechslungsreiche Geschichte einer Stadt erzählt wurde. Das Brettspiel startet mit einfachen Regeln, die einen schnellen Einstieg ermöglichen. Ein Spiel ist beendet? Dann werden Sticker, die sich in den acht verschlossenen Umschlägen befinden, auf den Plan geklebt. So entwickelt sich der Spielplan immer weiter.
In den nächsten Partien warten weitere Anforderungen und Spielmaterialien, die das Spiel voranbringen und immer wieder für Überraschungen sorgen.', 2, 1)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (10, N'Der Kartograph', CAST(14.16 AS Decimal(19, 2)), N'/Content/Images/Products/kartograph.jpg', N'Die nördlichen Reiche sollen endlich urbar gemacht und dem Königreich Nalos angeschlossen werden. Im Auftrag ihrer Majestät Königin Gimnax sollen die Spieler das Land kartieren. Doch auch die Dragul erheben Anspruch darauf. Die Kartographen müssen kluge Grenzen ziehen, um sich zu behaupten und dabei die begehrtesten Ländereien entdecken. Der Kartograph ist ein Flip and Write-Spiel aus dem Roll Player-Universum. Bis zu 100 Spieler können hier darum konkurrieren, die besten Ländereien zu kartographieren. Schnell macht dabei ein clever eingezeichneter Dragul dem Mitspieler einen Strich durch die Rechnung. ', 1, 2)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (11, N'Azul', CAST(24.99 AS Decimal(19, 2)), N'/Content/Images/Products/azul.jpg', N'Azul lädt dich dazu ein, die Wände des königlichen Palastes in Evora mit prunkvollen Fliesen zu verzieren. Die ursprünglich weiß-blauen Keramikfliesen, genannt Azulejos, wurden einst von den Mauren eingeführt. Die Portugiesen vereinnahmten sie ganz für sich, nachdem ihr König Manuel I. bei einem Besuch der Alhambra in Südspanien von der Schönheit der schmuckvollen Fliesen geradezu überwältigt worden war. Sofort wies er seinen Bediensteten an, dass die Wände seines eigenen Palastes in Portugal mit ähnlich prachtvollen Fliesen zu verzieren seien. ', 1, 1)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (12, N'Munchkin 1+2', CAST(14.16 AS Decimal(19, 2)), N'/Content/Images/Products/munchkin12.jpg', N'Ein schnelles und albernes Spiel, das längst seinen weltweiten Siegeszug angetreten hat. Munchkin kann jede Gruppe in einen hysterischen Lachanfall treiben. Und während sie lachen, klaust du ihr Zeug. Das Kultspiel liegt 2013 neu in unserer beliebten Doppelschachtel vor und enthält zudem die erste Erweiterung Munchkin 2: Abartige Axt. Um was es geht? Hieran hat sich nichts geändert: Geh in den Dungeon. Töte alles was sich bewegt. Fall deinen Freunden in den Rücken und klau ihr Zeug. Greif dir den Schatz und dann Renn. Gib zu, du liebst es. Dieses Kartenspiel fängt die Erfahrungen eines Dungeons ein ... ohne das nervige Rollenspiel. Alles, was du noch zu tun hast, ist, Monster zu töten und dir magische Gegenstände einsacken... und steige Stufen auf. Munchkin - Töte die Monster Klau den Schatz Erstich deine Kumpels, so heißt es 2013 bereits im 10. Jahr auf Deutsch. Zum großen Jubiläum wird es eine groß angelegte Promotion-Tour, die Munchkin-Crusade 2013, für Ladengeschäfte geben. ', 1, 2)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (13, N'Munchkin 3+4', CAST(14.16 AS Decimal(19, 2)), N'/Content/Images/Products/munchkin34.jpg', N'Die Munchkins kehren zurück in den Dungeon mit dieser Doppelbox bestehend aus den Erweiterungen Munchkin 3: Beschwörungsfehler und Munchkin 4: Rasende Rösser. - Durchstreife den Dungeon mit der Rasse Gnome und der Klasse Barde. - Stell dich den Doppelgangstern, dem Degen-Fuzzy oder der Medusa. - Übe dich im Zwergenweitwurf und pass auf deinem Weg ins Dungeonkasino auf, dass du nicht in die Touristenfalle stolperst. - Rüste dich mit verblüffenden Gegenständen wie dem Kettenhemd-Bikini, dem Dolch-O-Mat oder dem gelegentlich zuverlässigen Amulett aus. - Galoppier auf dem Tiger, dem Drachen, der Riesigen Mutanten-Wüstenrennmaus, dem Adler oder sogar auf dem Huhn in den Dungeon. - Mache dir eine Heerschar an Mietlingen zu nutze, setze ihre speziellen Fertigkeiten ein, und opfere sie, um deine eigene Haut zu retten! Oder noch besser, töte einen Mietling von jemand anderem – das ist es, was ein wahrer Munchkin macht! Dies ist eine Erweiterung zu Munchkin, kein Basisspiel. Zum Spielen benötigt man das Basisspiel Munchkin. Alle Regeländerungen der 2011er Edition sind enthalten. ', 1, 2)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (14, N'Munchkin 5+6+6.5', CAST(14.16 AS Decimal(19, 2)), N'/Content/Images/Products/munchkin56.jpg', N'Noch mehr vom abgedrehten Humor von Steve Jackson und John Kovalic findest du in dieser Munchkin-Dreifachbox bestehend aus den Erweiterungen Wirre Waldläufer (5), Durchgeknallte Dungeons (6) und Grausige Grüfte (6.5). - Bändige Monster und mache sie zu Reittieren mit der neuen Waldläufer-Klasse. - Finde den Stein der Weisen, male Rallyestreifen auf dein Ross und fülle deine Feldflasche des Zorns mit Taufrischem Wasser. - Hüte dich vor neuen Monstern wie dem Telefonverkäufer, dem Gackergeist und den Untoten Clowns. - Erkunde 40 großformatige Dungeonkarten. Dies ist eine Erweiterung zu Munchkin, kein Basisspiel. Zum Spielen benötigst du das Basisspiel Munchkin. ', 1, 2)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (15, N'Munchkin 7+8', CAST(14.16 AS Decimal(19, 2)), N'/Content/Images/Products/munchkin78.jpg', N'Noch mehr vom abgedrehten Humor von Steve Jackson und John Kovalic findest du in dieser Munchkin-Doppelbox bestehend aus den Erweiterungen Mit beiden Händen schummeln (7) und Echsenmenschen & Zentauren (8). - Sorge für Chaos mit komplett überpowerten Karten: werde zum Ultra Munchkin oder zum Drittel-Blut und wenn dich eine normale Schummeln-Karte nicht zufrieden stell, dann kannst du jetzt Mit beiden Händen schummeln! - Erlebe den Auftritt der klassischen Fantasy-Rassen Echsenmenschen und Zentauren. - Nutze neue Rassen- und Klassenverstärker wie Elite, Legendär oder Älterer. Dies ist eine Erweiterung zu Munchkin, kein Basisspiel. Zum Spielen benötigst du das Basisspiel Munchkin. ', 1, 2)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (16, N'Magic the Gathering MTG Hauptset 2021 Arena', CAST(8.33 AS Decimal(19, 2)), N'/Content/Images/Products/mtghauptset.jpg', N'2 spielbereite 60 Karten Decks (Deutsch), Magic: The Gathering Regelbuch, 2 Deckboxen, 1 MTG Arena Code zum Freischalten digitaler Kopien der Decks in MTG Arena ', 3, 2)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (17, N'Magic: The Gathering Spellslinger Starter Kit', CAST(9.16 AS Decimal(19, 2)), N'/Content/Images/Products/mtgspellslinger.jpg', N'Alles, was Sie brauchen, um zu starten: Das Spellslinger Starter-Set enthält zwei Spieler-Kartendecks, zwei 20-seitige Kreislauf-Lifezähler, zwei Kurzanleitungen und zwei Regelhefte. Wählen Sie Ihr Deck: Wählen Sie das rote Deck, um wilde Drachen zu befehlen, oder weiß, um rechtshändige Engel in den Kampf zu befehlen. Spielen Sie online und offfline: Finden Sie einen Code, um beide Decks auf Magic: The Gathering Arena freizuschalten. ', 3, 2)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (18, N'MTG Hauptset 2021 Planeswalker Deck', CAST(39.99 AS Decimal(19, 2)), N'/Content/Images/Products/mtgplaneswalker.jpg', N'MTG Hauptset 2021 Planeswalker Deck Deutsch ', 3, 2)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (19, N'Nintendo Switch Konsole Grau', CAST(262.49 AS Decimal(19, 2)), N'/Content/Images/Products/switchgrau.jpg', N'Die TV-Konsole für zuhause und unterwegs!
Nintendo Switch wird nicht nur zu Hause für aufregenden Einzel- und Mehrspielerspaß sorgen. Nintendo-Freunde können dieselben Titel nun auch unterwegs weiterspielen – gleichgültig wo, wann und mit wem. Nintendo Switch verbindet die Mobilität eines tragbaren Systems mit der Leistungsstärke einer TV-Konsole und eröffnet damit nie dagewesene Spielerlebnisse.

Im heimischen Wohnzimmer steht die neue Konsole in der Nintendo Switch-Station, die das Gerät mit dem Fernseher verbindet – perfekt für das gemütliche Spiel mit Familie und Freunden vom Sofa aus. Nehmen die Spieler Nintendo Switch aus der Station heraus, wechselt die Konsole sofort in den Handheld-Modus. So können die Nintendo-Fans denselben Spielspaß auch unterwegs genießen. Der in die Konsole integrierte, helle HD-Bildschirm sorgt dabei für eine optimale Spielerfahrung wie am Fernseher – somit auch im Park, im Zug, im Auto oder bei einem anderen Nintendo-Freund zu Hause.

Und weil geteilter Spielspaß doppelter Spielspaß ist, lassen sich die Joy-Con-Controller, die an beiden Seiten der Konsole angebracht sind, von Nintendo Switch lösen. Das ermöglicht die unterschiedlichsten Spielkombinationen: ein Spieler mit je einem Joy-Con-Controller in jeder Hand, zwei Spieler mit je einem oder viele Spieler mit mehreren Joy-Con-Controllern.

So leicht sie sich abnehmen lassen, so leicht kann man die Controller auch wieder anbringen, ob an der Konsole oder an der Joy-Con-Halterung, die einem traditionellen Controller ähnelt. Wer mag, kann neben den Joy-Con-Controllern auch den optionalen Nintendo Switch Pro Controller verwenden. Damit nicht genug, können die Spieler mehrere Nintendo Switch-Konsolen lokal miteinander verbinden. Auch das steigert die fesselnde Mehrspieler-Action.', 4, 5)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (20, N'Nintendo Switch Konsole Neon-Rot/Neon-Blau', CAST(262.49 AS Decimal(19, 2)), N'/Content/Images/Products/switchneon.jpg', N'Die TV-Konsole für zuhause und unterwegs!
Nintendo Switch wird nicht nur zu Hause für aufregenden Einzel- und Mehrspielerspaß sorgen. Nintendo-Freunde können dieselben Titel nun auch unterwegs weiterspielen – gleichgültig wo, wann und mit wem. Nintendo Switch verbindet die Mobilität eines tragbaren Systems mit der Leistungsstärke einer TV-Konsole und eröffnet damit nie dagewesene Spielerlebnisse.

Im heimischen Wohnzimmer steht die neue Konsole in der Nintendo Switch-Station, die das Gerät mit dem Fernseher verbindet – perfekt für das gemütliche Spiel mit Familie und Freunden vom Sofa aus. Nehmen die Spieler Nintendo Switch aus der Station heraus, wechselt die Konsole sofort in den Handheld-Modus. So können die Nintendo-Fans denselben Spielspaß auch unterwegs genießen. Der in die Konsole integrierte, helle HD-Bildschirm sorgt dabei für eine optimale Spielerfahrung wie am Fernseher – somit auch im Park, im Zug, im Auto oder bei einem anderen Nintendo-Freund zu Hause.

Und weil geteilter Spielspaß doppelter Spielspaß ist, lassen sich die Joy-Con-Controller, die an beiden Seiten der Konsole angebracht sind, von Nintendo Switch lösen. Das ermöglicht die unterschiedlichsten Spielkombinationen: ein Spieler mit je einem Joy-Con-Controller in jeder Hand, zwei Spieler mit je einem oder viele Spieler mit mehreren Joy-Con-Controllern.

So leicht sie sich abnehmen lassen, so leicht kann man die Controller auch wieder anbringen, ob an der Konsole oder an der Joy-Con-Halterung, die einem traditionellen Controller ähnelt. Wer mag, kann neben den Joy-Con-Controllern auch den optionalen Nintendo Switch Pro Controller verwenden. Damit nicht genug, können die Spieler mehrere Nintendo Switch-Konsolen lokal miteinander verbinden. Auch das steigert die fesselnde Mehrspieler-Action.', 4, 5)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (21, N'Nintendo Switch Lite Grau', CAST(166.66 AS Decimal(19, 2)), N'/Content/Images/Products/switchlitegrau.jpg', N' Nintendo Switch Lite ist das kompakte Leichtgewicht der Nintendo Switch-Familie mit integrierter Steuerung.

Auf Nintendo Switch Lite können alle Nintendo Switch-Titel gespielt werden, die den Handheld-Modus unterstützen – ideal für alle, die oft unterwegs sind und dabei auch online oder lokal mit Freunden und Familie spielen möchten, die bereits das Aushängeschild Nintendo Switch haben.

Da Nintendo Switch Lite eine eigens für Handheld-Spiel konzipierte Spielekonsole ist, unterstützt sie die Wiedergabe auf dem Fernseher nicht. ', 4, 5)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (22, N'Nintendo Switch Lite Koralle', CAST(166.66 AS Decimal(19, 2)), N'/Content/Images/Products/switchlitekoralle.jpg', N' Nintendo Switch Lite ist das kompakte Leichtgewicht der Nintendo Switch-Familie mit integrierter Steuerung.

Auf Nintendo Switch Lite können alle Nintendo Switch-Titel gespielt werden, die den Handheld-Modus unterstützen – ideal für alle, die oft unterwegs sind und dabei auch online oder lokal mit Freunden und Familie spielen möchten, die bereits das Aushängeschild Nintendo Switch haben.

Da Nintendo Switch Lite eine eigens für Handheld-Spiel konzipierte Spielekonsole ist, unterstützt sie die Wiedergabe auf dem Fernseher nicht. ', 4, 5)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (23, N'Playstation 4 Slim', CAST(274.99 AS Decimal(19, 2)), N'/Content/Images/Products/ps4slim.jpg', N'PlayStation 4 – Play. Redesigned.

SCHLANKER, LEICHTER, NEUER LOOK.

PlayStation 4 die meistverkaufte Konsole der Welt jetzt noch leichter und in einem schlankeren Design.

Durch eine umfassende Überarbeitung der internen Design-Architektur der neuen PS4 wurden die Abmessungen um mehr als 30% im Vergleich zum Vorgänger-Modell und das Gewicht um 25% im Vergleich zum allersten und um 16% zum aktuellen PS4-Modell reduziert.

Außerdem ist die neue PS4 noch energieeffizienter. Der Stromverbrauch wurde um mehr als 34% und 28% im Vergleich zum ersten und aktuellen Modell gesenkt.

Bei der neuen PS4 wurde das angeschrägte Gehäuse-Design der Vorgängermodelle übernommen. Die gekürzten und abgerundeten Ecken geben der Konsole eine weichere Anmutung. Das glänzende PlayStation Family Logo in der Mitte der oberen Fläche vollendet das neue stylische Design. ', 5, 5)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (24, N'Playstation 4 Pro', CAST(307.50 AS Decimal(19, 2)), N'/Content/Images/Products/ps4pro.jpg', N'PS4-Gaming der neuen Generation: Dank ultrascharfer Grafik, atemberaubend lebendiger Farben und flüssiger, stabiler Leistung erwachen deine PS4-Spiele zum Leben. Alle PS4-Titel werden auf PS4 Pro mit mindestens 1080p wiedergegeben. Manche Spiele verfügen über integrierte Features für PS4 Pro, andere werden mit noch besserer Leistung und Grafik dargestellt. Anhand des "PS4 PRO OPTIMIERT"-Logos erkennst du sofort, welche Spiele für diese unglaubliche Power optimiert sind.', 5, 5)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (25, N'Playstation 5', CAST(415.83 AS Decimal(19, 2)), N'/Content/Images/Products/ps5.jpg', N'Die PS5™-Konsole eröffnet völlig neue Gaming-Möglichkeiten, die du so nie erwartet hättest. Freue dich auf blitzschnelles Laden mit einer ultraschnellen SSD, eine realistischere Spielerfahrung durch haptisches Feedback, adaptive Trigger-Tasten¹ und 3D-Audio¹ sowie eine völlig neue Generation unglaublicher PlayStation®-Spiele. ', 5, 5)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (26, N'Playstation 5 Digital-Edition', CAST(332.50 AS Decimal(19, 2)), N'/Content/Images/Products/ps5digital.jpg', N'Die PS5™-Konsole eröffnet völlig neue Gaming-Möglichkeiten, die du so nie erwartet hättest. Freue dich auf blitzschnelles Laden mit einer ultraschnellen SSD, eine realistischere Spielerfahrung durch haptisches Feedback, adaptive Trigger-Tasten¹ und 3D-Audio¹ sowie eine völlig neue Generation unglaublicher PlayStation®-Spiele. ', 5, 5)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (27, N'Xbox One S', CAST(244.99 AS Decimal(19, 2)), N'/Content/Images/Products/xboxones.jpg', N'Erlebe kräftigere und leuchtendere Farben in den Spielen und Videos mit High Dynamic Range. Streame 4K Videos auf Netfl ix und Amazon Video und sieh Blue-Ray Filme in atemberaubendem 4K Ultra HD. Verbesserter Komfort und Haptik des neuen Xbox Controllers werden durch den Textured Grip und Bluetooth unterstützt. ', 6, 5)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (28, N'Xbox Series S', CAST(242.49 AS Decimal(19, 2)), N'/Content/Images/Products/xboxseriess.jpg', N'Wir präsentieren die Xbox Series S, die kompakteste und schlankeste Xbox-Konsole aller Zeiten. Erleben Sie die Geschwindigkeit und Leistung einer Next-Gen All-Digital Konsole zu einem attraktiven Preis. Starten Sie durch mit Xbox Game Pass Ultimate und erhalten Sie Zugriff auf über 100 großartige Spiele, eine EA Play-Mitgliedschaft, Online-Multiplayer und alle neuen Xbox Game Studios-Titel am Tag ihrer Veröffentlichung (Mitgliedschaft separat erhältlich, EA Play ab Ende 2020 enthalten). Mit Quick Resume können Sie im Handumdrehen nahtlos zwischen mehreren Spielen wechseln. Das Herzstück der Series S ist die Xbox Velocity Architecture, die eine eigens entwickelte SSD mit integrierter Software für ein schnelleres, optimiertes Gameplay mit deutlich reduzierten Ladezeiten kombiniert. ', 6, 5)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (29, N'Xbox Series X', CAST(415.83 AS Decimal(19, 2)), N'/Content/Images/Products/xboxseriesx.jpg', N'Xbox Series X ist die schnellste und leistungsstärkste Konsole aller Zeiten. Genießen Sie Tausende Spiele aus vier Konsolengenerationen, die sich nie besser gespielt haben und prachtvoller waren als auf Xbox Series X. Das Herzstück der Xbox Series X ist die Xbox Velocity Architecture, die eine speziell entwickelte SSD und Software vereint und Spielwelten in Sekundenschnelle lädt. Mit Quick Resume können Sie blitzschnell zwischen mehreren Spielen wechseln. Entdecken Sie immersive neue Welten und genießen Sie Action wie nie zuvor mit unübertroffenen 12 Teraflops Rechenleistung. Genießen Sie 4K-Spiele mit bis zu 120 Bildern pro Sekunde, innovativen 3D-Raumklang und vieles mehr. Starten Sie durch mit Xbox Game Pass Ultimate und erhalten Sie Zugriff auf über 100 großartige Spiele, eine EA Play-Mitgliedschaft, Online-Multiplayer und alle neuen Xbox Game Studios-Titel am Tag ihrer Veröffentlichung (Mitgliedschaft separat erhältlich, EA Play ab Ende 2020 enthalten). ', 6, 5)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (30, N'The Legend of Zelda: Breath of the Wild', CAST(45.00 AS Decimal(19, 2)), N'/Content/Images/Products/tlozbotw.jpg', N'Vergessen Sie, was Sie bisher über „The Legend of Zelda“ wissen! Begeben Sie sich in eine neue Welt voller Abenteuer und Entdeckungen in „The Legend of Zelda: Breath of the Wild“, einem innovativen neuen Spiel in der beliebten Reihe. Reisen Sie über Felder, durch Wälder und auf Berggipfel, und finden Sie im Laufe dieses mitreißenden Abenteuers heraus, was aus dem zerstörten Königreich von Hyrule geworden ist. ', 4, 3)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (31, N'Super Mario Odyssey', CAST(40.41 AS Decimal(19, 2)), N'/Content/Images/Products/smodyssey.jpg', N'Erleben Sie mit Mario ein gewaltiges, weltumspannendes 3D-Abenteuer und nutzen Sie seine unglaublichen neuen Fähigkeiten! Sammeln Sie Monde als Treibstoff für das Luftschiff und retten Sie Prinzessin Peach vor Bowser, der Heiratspläne schmiedet! ', 4, 3)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (32, N'Mario Kart 8 Deluxe', CAST(40.83 AS Decimal(19, 2)), N'/Content/Images/Products/smk8dx.jpg', N'Mit Nintendo Switch können Fans in der definitiven Version von „Mario Kart 8“ wann und wo sie wollen spannenden Rennen fahren – sogar mit bis zu acht Freunden im lokalen Mehrspielermodus.

Mario Kart 8 Deluxe beinhaltet neben allen Strecken und Charakteren aus der Wii U-Version auch alle Strecken und Charaktere, die bisher nur als herunterladbare Inhalte verfügbar waren. Dazu steigen auch ein paar neue Charaktere in den Fahrspaß ein: der Inkling-Junge und das Inkling-Mädchen aus Splatoon, König Buu Huu, Knochentrocken und Bowser Jr.! Dazu wurde der Schlacht-Modus überarbeitet und kann nun ebenfalls mit Ballonschlacht und Bob-omb-Wurf aufwarten, mit neuen Strecken wie Dekabahnstation und Kampfarena und wiederkehrenden Strecken wie Luigi‘s Mansion aus Mario Kart: Double Dash!! für den Nintendo GameCube und Kampfkurs 1 aus Super Mario Kart für das Super Nintendo Entertainment System.

Wem ein Item noch nie genug war, der kann sich nun darauf freuen, zwei Items gleichzeitig bei sich zu haben. Auch neue Items aus vorherigen Titeln der Reihe sind diesmal dabei, so zum Beispiel Buu Huu, der Items stiehlt, und die Feder, die in der Schlacht besonders hohe Sprünge ermöglicht. Eine weitere Neuerung dürfte besonders Anfänger freuen: Die sogenannte Schlau-Steuerung macht es wesentlich einfacher, beim Fahren auf der Straße zu bleiben. So können auch Kinder sich in 200-ccm-Rennen beweisen. Gespielt wird lokal oder online im TV-Modus mit bis zu 12 Spielern.', 4, 3)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (33, N'Animal Crossing: New Horizons', CAST(40.42 AS Decimal(19, 2)), N'/Content/Images/Products/acnh.jpg', N'Ist dir das moderne Leben einfach zu hektisch? Dann ist Tom Nooks neueste Geschäftsidee wie für dich geschaffen: Entdecke das Reif-für-die-Insel-Paket von Nook Inc.!

Du hast dich mit vielen einzigartigen Nachbarn angefreundet, hast dir die Großstadt angesehen und als Bürgermeister viel für deine Gemeinschaft getan. Doch steckt tief in dir drin nicht der Wunsch nach Freiheit, nach einer Chance, das zu tun, was du willst? Der Wunsch nach unberührter Natur? Dann klingt ein Strandspaziergang auf einer einsamen Insel doch genau richtig!

Auf diesem idyllischen Fleckchen Erde entscheidest du allein, was du mit deinem Leben machen möchtest. Also, kremple die Ärmel hoch und lass deiner Kreativität freien Lauf.

Sammle Materialien und baue daraus einfach alles, von bequemen Hockern bis zu praktischen Werkzeugen. Hobbygärtner können hier ganz neue Möglichkeiten entdecken, um mit Blumen und Bäumen zu interagieren. In deiner Siedlung entscheidest du alles – lass dir von niemandem erzählen, welche Möbel nach drinnen oder draußen gehören!

Freunde dich mit Neuankömmlingen an, springe beim Erkunden im Stabhochsprung über Flüsse, genieße die Jahreszeiten auf deinem Inselparadies und mehr!', 4, 3)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (34, N'Pokémon Schild', CAST(36.58 AS Decimal(19, 2)), N'/Content/Images/Products/pokemonschild.jpg', N'Eine neue Generation von Pokémon wird für die Nintendo Switch™ erscheinen. Werde ein Pokémon Trainer und Teil einer neuen Reise in der neuen Galar Region! Wähle eines von 3 Partner-Pokémon: Grookey, Scorbunny oder Sobble. In diesem völlig neuen Abenteuer wirst du neuen und bekannten Pokémon antreffen indem du sie fängst, um sie kämpfst oder handelst. Dabei wirst du neue Umgebung und Stories entdecken. Mach dich bereit für das nächste Pokémon Abenteuer mit der Pokémon™ Sword und Pokémon™ Shield Edition. ', 4, 3)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (35, N'Pokémon Schwert', CAST(36.58 AS Decimal(19, 2)), N'/Content/Images/Products/pokemonschwert.jpg', N'Eine neue Generation von Pokémon wird für die Nintendo Switch™ erscheinen. Werde ein Pokémon Trainer und Teil einer neuen Reise in der neuen Galar Region! Wähle eines von 3 Partner-Pokémon: Grookey, Scorbunny oder Sobble. In diesem völlig neuen Abenteuer wirst du neuen und bekannten Pokémon antreffen indem du sie fängst, um sie kämpfst oder handelst. Dabei wirst du neue Umgebung und Stories entdecken. Mach dich bereit für das nächste Pokémon Abenteuer mit der Pokémon™ Sword und Pokémon™ Shield Edition. ', 4, 3)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (36, N'Super Mario Party', CAST(39.16 AS Decimal(19, 2)), N'/Content/Images/Products/supermarioparty.jpg', N'FEIERE MARIO PARTY, JEDERZEIT UND ÜBERALL!

Das übliche Brettspiel-Gameplay wurde um neue strategische Elemente ergänzt, wie Würfel, die nur von bestimmten Charakteren verwendet werden können. Auch ganz neue Spielmethoden finden sich im Spiel, darunter Minispiele, die die Funktionsweise der Joy-Con-Controller ausreizen, und neue Spielmodi, die deine Freunde und Familie begeistern werden.

Die Brettspielmechanik kehrt zurück zum klassischen Vier-Spieler-Modell, in dem die Spieler auf der Jagd nach Sternen abwechselnd würfeln und über das Spielbrett ziehen. Du kannst sogar zwei Nintendo Switch-Konsolen miteinander verbinden und dynamische neue Spielstile wie den Modus "Toads Freizeitraum“ genießen.

Die Mischung aus neuen Modi und Minispielen mit dem klassischen Brettspielstil sorgt für aufregenden Partyspaß, wann, wo und mit wem du willst!
', 4, 3)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (37, N'CATAN - Das Spiel', CAST(18.33 AS Decimal(19, 2)), N'/Content/Images/Products/catan.jpg', N'Versetzt euch in das Zeitalter der Entdecker: Die Schiffe haben nach langer, entbehrungsreicher Seefahrt die Küste einer unbekannten Insel erreicht. Catan soll sie heißen. Doch ihr seid nicht die einzigen. Auch andere unerschrockene Seefahrer sind an der Küste Catans gelandet: Der Wettlauf um die Besiedlung hat begonnen.
Der Einstieg in den Spieleklassiker ist ganz einfach: Das clevere Regelkonzept ermöglicht einen schnellen Start. Nach nur wenigen Seiten Regeln kann es losgehen – für spätere Fragen und Details gibt es einen kleinen Almanach zum Nachschlagen. Alternativ kann direkt mit der die KOSMOS-App „Catan Brettspiel Assistent“ losgespielt werden, welcher kostenlos für Apple und Android Geräte erhältlich ist. Für 3–4 Siedler ab 10 Jahren.
Und das sagt die Jury vom Spiel des Jahres e.V.: „DIE SIEDLER VON CATAN bestechen durch klaren Aufbau, logische Struktur und eine harmonische Verbindung von verschiedenen Spielelementen, die zusammen ein einmaliges Spielerlebnis bieten. Dabei werden […] die verschiedensten Spielcharaktere angesprochen: der gewiefte Taktiker, der kühle Rechner und der wortgewandte Händler. Das Eintauchen in eine phantastische, vielschichtige Spielwelt wird erleichtert durch eine hier erstmals verwirklichte Regelgestaltung […], die zum Mitspielen direkt einlädt. Zum Mitmachen bei einem Spiel, das garantiert ein Klassiker wird.“ (Spiel des Jahres e.V. (1995): Die Siedler von Catan. Webseite von Spiel des Jahres e.V. zu Die Siedler von Catan, Abgerufen am 03.06.2019).', 2, 1)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (38, N'Tribes', CAST(18.33 AS Decimal(19, 2)), N'/Content/Images/Products/tribes.jpg', N'Die Erde vor 10.000 Jahren: Die Spieler führen ihren Stamm durch die Frühgeschichte der Menschheit bis in die Bronzezeit. Sie erkunden neues Land, das besiedelt werden kann und erhalten Zugriff auf wertvolle Ressourcen, die neue Entdeckungen und Erfindungen erlauben. Jeder Spieler muss sich zusätzlich auf verschiedene Ereignisse – Naturkatastrophen, Krankheiten oder feindliche Überfälle – einstellen, um schließlich als erfolgsreichster Stamm dazustehen. Das abwechslungsreiche Strategiespiel zur spannenden Geschichte unserer Zivilisation. Für 2 – 4 Spieler ab 10 Jahren. ', 2, 1)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (39, N'Lumis - Der Pfad des Feuers', CAST(24.96 AS Decimal(19, 2)), N'/Content/Images/Products/lumis.jpg', N'Ein Pfad aus leuchtenden Feuersteinen soll erschaffen werden. Turmsteine kann man auf gleichfarbige Turmfelder setzen und mit seinen Feuersteinen markieren. Durch Feuersteine werden auch eigene Türme miteinander verbunden. Doch für alles braucht man die passenden Karten. Und stets muss man überlegen, ob man selbst aktiv wird oder ob es besser ist, für seinen Teampartner einen Zug vorzubereiten. Zumal die Mitspieler nicht schlafen. Sie können Türme übernehmen und Verbindungen blockieren. So bleibt das Spiel spannend bis zum letzten Zug. Für 2 oder 4 Spieler ab 10 Jahren. ', 2, 1)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (40, N'Tainted Grail', CAST(83.33 AS Decimal(19, 2)), N'/Content/Images/Products/taintedgrail.jpg', N'Tainted Grail ist ein Überlebens- und Erkundungsspiel, welches die Artussage und die keltische Mythologie zu einer einzigartigen, düsteren Vision verbindet. Die Spieler kontrollieren einen von vier ungewöhnlichen Charakteren, die mit unvorstellbaren Widrigkeiten konfrontiert werden, bei denen stärkere und weisere Helden versagt haben. Verfolgt von der überwältigenden Kraft der Wyrdnis machen sie sich daran, Avalon vor dem Untergang zu bewahren.

Bei Tainted Grail wählt jeder Spieler einen der vier einzigartigen Charaktere, von denen jeder andere Startvoraussetzungen und Fähigkeiten besitzt. Als Gruppe und auch auf eigene Faust bereisen sie Avalon. Sie interagieren mit Bewohnern, erkunden geheimnisvolle Orte, sammeln Nahrung und Kämpfen gegen zahlreiche Feinde. Bei den Kämpfen und Diplomatie-Begegnungen kommt eine innovative Kartenmechanik zum Einsatz. Immer wieder lesen die Spieler Abschnitte aus dem Buch der Entdeckungen und treffen Entscheidungen, die das Spielgeschehen beeinflussen. Dabei kann es manchmal wichtig sein, welcher Charakter in diesem Moment dabei ist.

Achtung: Dies ist die Retail-Edition von Tainted Grail. Die Figuren sind unbehandelt. Der Kickstarter-exklusive Charakter Niamh ist nicht enthalten. ', 1, 1)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (41, N'Detective', CAST(24.99 AS Decimal(19, 2)), N'/Content/Images/Products/detective.jpg', N'Detective ist ein modernes Krimi-Spiel, gestaltet von Ignacy Trzewiczek, mit einer Geschichte von Przemysław Rymer und Jakub Łapot. Hier schlüpfen die Spieler in die Rollen von echten Ermittlern in modernem Setting. Als Teammitglieder der Antares National Investigation Agency müssen sie mysteriöse Verbrechen lösen. Detective verwickelt die Spieler tief in eine reichhaltige Geschichte. Bleibt zu hoffen, dass sie es schaffen, das Ende vorherzusehen, bevor ein weiteres Verbrechen geschieht... Das Spiel fordert sie mit fünf verschiedenen Fällen heraus. Scheinen diese zunächst noch ohne Zusammenhang zu sein, enthüllen sie doch mit der Zeit einen immersiven Metaplot, der gleichwohl auf Fakten und Fiktion beruht. Als Agenten begeben sich die Spieler in ein städtisches Labyrinth aus alten Mysterien und frischen Verbrechen und müssen immer wieder aufs Neue entscheiden, welchen Hinweisen sie nachgehen und welchen nicht – denn die Zeit ist begrenzt. Noch nie hat ein Spiel in derselben Weise die vierte Wand durchbrochen wie Detective! Die Spieler müssen alle verfügbaren Ressourcen nutzen: sie können die ausführliche Datenbank des Spiels durchstöbern, die die Ressourcen ihrer Agentur simuliert, im Internet recherchieren und jedes andere Hilfsmittel zurate ziehen, das die reale Welt ihnen bietet. Dabei decken sie beständig neue Hinweise auf, die sie nach und nach näher an die Auflösung der Fälle bringen. ', 1, 1)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (42, N'Port Royal', CAST(7.49 AS Decimal(19, 2)), N'/Content/Images/Products/portroyal.jpg', N'Die Karibik im goldenen Zeitalter der Piraterie: Große Gefahren lauern in diesen Gewässern. Doch die Aussicht auf unermesslichen Reichtum rechtfertigt so manches Risiko. Die Spieler begeben sich in Port Royal auf die Suche nach einer schlagkräftigen Crew und versuchen gierige Freibeuter zu meiden. Nur wer wagt, wird seinen Einfluss steigern und schließlich einem königlichen Expeditionsaufruf folgen können. Aber wer zu viel riskiert, läuft Gefahr, alles zu verlieren.

Port Royal ist ein mehrfach ausgezeichnetes, schnelles Kartenspiel mit der vollen Breitseite Piraten-Flair. Dank der einfachen Regel können die Spieler sofort in See stechen und bei der Erkundung fremder Gewässer ihren Mut beweisen.

Das Spiel gewann unter dem Titel „Händler der Karibik“ den Spieleautoren-Wettbewerb 2013 der Wiener Spiele Akademie.', 1, 2)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (43, N'BAM!', CAST(14.80 AS Decimal(19, 2)), N'/Content/Images/Products/bam.jpg', N'Es macht wieder BAM! - und dieses mal noch länger, noch tiefer und noch härter! In diesem Partyspiel füllen die Spieler Lückentexte auf Karten mit passenden Begriffen. Grammatik oder Korrektheit (besonders politische) sind egal. Es gilt einzig und allein, den BAM! -Master zu überzeugen, dass der eigene Begriff der originellste und witzigste ist. BAM! - Länger, tiefer, härter! enthält jede Menge prämierter Karten, die besten Fan-Einsendungen und krasse Joker mit 4 Begriffen darauf. Richtig extrem - so wie BAM! -Spieler es mögen. ', 1, 2)
GO
INSERT [dbo].[Product] ([Id], [Name], [NetUnitPrice], [ImagePath], [Description], [ManufacturerId], [CategoryId]) VALUES (44, N'Das Verlies', CAST(8.66 AS Decimal(19, 2)), N'/Content/Images/Products/dasverlies.jpg', N' Sie erwachen in einem dunklen Kerker. Wie sind sie bloß hier gelandet? Jede Erinnerung an die Vergangenheit ist ausgelöscht.

Um der Lösung der seltsamen Ereignisse näher zu kommen, müssen alle – ähnlich wie in einem Adventure PC-Spiel – gemeinsam Räume nach Hinweisen und Gegenständen durchforschen, diese kombinieren und mit Personen sprechen, die ihnen dabei begegnen. Schritt für Schritt ergibt sich ein Gesamtbild. ', 2, 2)
GO
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[OrderLine]  WITH CHECK ADD FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([Id])
GO
ALTER TABLE [dbo].[OrderLine]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([ManufacturerId])
REFERENCES [dbo].[Manufacturer] ([Id])
GO
