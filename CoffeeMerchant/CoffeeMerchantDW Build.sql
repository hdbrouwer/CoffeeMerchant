IF NOT EXISTS(SELECT * FROM sys.databases
	WHERE name = N'DWCoffeeMerchantSales')
	CREATE DATABASE DraftKingsDM
GO
USE DWCoffeeMerchantSales
GO

-- Drop Things

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE name = N'FactSales'
       )
	DROP TABLE FactSales;

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE name = N'DimEmployee'
       )
	DROP TABLE DimEmployee;

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE name = N'DimDates'
       )
	DROP TABLE DimDates;

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE name = N'DimConsumer'
       )
	DROP TABLE DimConsumer;

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE name = N'DimInventory'
       )
	DROP TABLE DimInventory;

--Table Dates
USE [DWCoffeeMerchantSales]
GO

CREATE TABLE [dbo].[DimDates](
       	[DateSK]			INT IDENTITY(1,1)		NOT NULL PRIMARY KEY,
       	[Date]				DATETIME				NOT NULL UNIQUE,
       	[DateName] 			NVARCHAR(50)			NOT NULL,
       	[Month]	 			INT						NOT NULL,
       	[MonthName]			NVARCHAR(50)			NOT NULL,
       	[Quarter]			INT						NOT NULL,
       	[QuarterName]		NVARCHAR(50)			NOT NULL,
       	[Year] 				INT						NOT NULL,
       	[YearName] 			NVARCHAR(50)			NOT NULL,
)
GO

-- Table Employee

CREATE TABLE DimEmployee
	(EmployeeSK    			INT IDENTITY (1,1)		NOT NULL PRIMARY KEY, 
	EmployeeAK 				INT						NOT NULL,
	Name					NVARCHAR(60)			NOT NULL,
	CommissionRate 			NUMERIC(4,4)			NOT NULL,
	HireDate       			DATETIME				NOT NULL,
	Gender         			NVARCHAR(1)				NOT NULL,
	)
GO

-- Table Consumer

CREATE TABLE DimConsumer(
	ConsumerSK				INT IDENTITY (1, 1)		NOT NULL PRIMARY KEY,
	ConsumerAK 				INT						NOT NULL,
	ConsumerCity 			NVARCHAR(20)			NOT NULL,
	ConsumerState 			NVARCHAR(20)			NOT NULL,
	ConsumerZipcode 		NVARCHAR(10)			NOT NULL,
	ConsumerCreditLimit		INT						NOT NULL,
) 
GO

--Inventory Table

CREATE TABLE DimInventory(
InventorySK					INT IDENTITY (1, 1)		NOT NULL PRIMARY KEY,
InventoryAK					INT						NOT NULL,
InventoryName				NVARCHAR(40)			NOT NULL,
InventoryPrice				NUMERIC(6,2)			NOT NULL,
InventoryItemType			NVARCHAR(5)				NOT NULL,
InventoryCountryName		NVARCHAR(40)			NOT NULL,
InventoryOnHand				INT						NOT NULL
)
GO 

--Fact Table

CREATE TABLE [dbo].[FactSales](
    DateSK					INT	CONSTRAINT fk_DateSK FOREIGN KEY REFERENCES DimDates(DateSK)					NOT NULL,
    CustomerSK	 			INT	CONSTRAINT fk_ConsumerSK FOREIGN KEY REFERENCES DimConsumer(ConsumerSK)					NOT NULL,
    EmployeeSK	 			INT CONSTRAINT fk_EmployeeSK FOREIGN KEY REFERENCES DimEmployee(EmployeeSK)						NOT NULL,
    InventorySK				INT	CONSTRAINT fk_InventorySK FOREIGN KEY REFERENCES DimInventory(InventorySK)					NOT NULL,
	FullPrice				INT						NOT NULL,
	Revenue					INT						NOT NULL,
	Profit					INT						NOT NULL,
	DiscountPrice			NVARCHAR(10)			NOT NULL,
	TotalCommission			DATETIME				NOT NULL,
	Quality					NVARCHAR(25)			NOT NULL,
       	CONSTRAINT [PK_FactSales] PRIMARY KEY
       	(
       	DateSK,
       	CustomerSK,
       	InventorySK,
       	EmployeeSK
       	)
) 
GO
