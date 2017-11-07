IF NOT EXISTS(SELECT * FROM sys.databases
	WHERE name = N'DWCoffeeMerchantSales')
	CREATE DATABASE DWCoffeeMerchantSales
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
	WHERE name = N'DimDate'
	)
	DROP TABLE DimDate;

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

-- Create [dbo].[DimDate2]
CREATE TABLE [dbo].[DimDate]
	(	
	Date_SK INT PRIMARY KEY, 
	Date DATETIME,
	FullDate CHAR(10),-- Date in MM-dd-yyyy format
	DayOfMonth INT, -- Field will hold day number of Month
	DayName VARCHAR(9), -- Contains name of the day, Sunday, Monday 
	DayOfWeek INT,-- First Day Sunday=1 and Saturday=7
	DayOfWeekInMonth INT, -- 1st Monday or 2nd Monday in Month
	DayOfWeekInYear INT,
	DayOfQuarter INT,
	DayOfYear INT,
	WeekOfMonth INT,-- Week Number of Month 
	WeekOfQuarter INT, -- Week Number of the Quarter
	WeekOfYear INT,-- Week Number of the Year
	Month INT, -- Number of the Month 1 to 12{}
	MonthName VARCHAR(9),-- January, February etc
	MonthOfQuarter INT,-- Month Number belongs to Quarter
	Quarter CHAR(2),
	QuarterName VARCHAR(9),-- First,Second..
	Year INT,-- Year value of Date stored in Row
	YearName CHAR(7), -- CY 2015,CY 2016
	MonthYear CHAR(10), -- Jan-2016,Feb-2016
	MMYYYY INT,
	FirstDayOfMonth DATE,
	LastDayOfMonth DATE,
	FirstDayOfQuarter DATE,
	LastDayOfQuarter DATE,
	FirstDayOfYear DATE,
	LastDayOfYear DATE,
	IsHoliday BIT,-- Flag 1=National Holiday, 0-No National Holiday
	IsWeekday BIT,-- 0=Week End ,1=Week Day
	Holiday VARCHAR(50),--Name of Holiday in US
	Season VARCHAR(10)--Name of Season
	);


-- Table Employee

CREATE TABLE DimEmployee
	(EmployeeSK    			INT IDENTITY (1,1)		NOT NULL PRIMARY KEY, 
	EmployeeAK 				INT						NOT NULL,
	Name					NVARCHAR(60)			NOT NULL,
	CommissionRate 			NUMERIC(4,4)			NOT NULL,
	HireDate       			DATETIME				NOT NULL,
	BirthDate				DATETIME				NOT NULL,
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
    DateSK					INT	CONSTRAINT fk_DateSK FOREIGN KEY REFERENCES DimDate(Date_SK)					NOT NULL,
    ConsumerSK	 			INT	CONSTRAINT fk_ConsumerSK FOREIGN KEY REFERENCES DimConsumer(ConsumerSK)					NOT NULL,
    EmployeeSK	 			INT CONSTRAINT fk_EmployeeSK FOREIGN KEY REFERENCES DimEmployee(EmployeeSK)						NOT NULL,
    InventorySK				INT	CONSTRAINT fk_InventorySK FOREIGN KEY REFERENCES DimInventory(InventorySK)					NOT NULL,
	FullPrice				INT						NOT NULL,
	Revenue					INT						NOT NULL,
	DiscountPrice			INT			NOT NULL,
       	CONSTRAINT [PK_FactSales] PRIMARY KEY
       	(
       	DateSK,
       	ConsumerSK,
       	InventorySK,
       	EmployeeSK
       	)
) 
