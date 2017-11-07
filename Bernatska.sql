USE [master]
GO
IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'DWCoffeeMerchantSales')
  BEGIN
     -- Close connections to the DWNorthwindOrders database 
    ALTER DATABASE [DWCoffeeMerchantSales] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE [DWCoffeeMerchantSales]
  END
GO

CREATE DATABASE [DWCoffeeMerchantSales] ON  PRIMARY 
( NAME = N'DWCoffeeMerchantSales'
, FILENAME = N'C:\_BISolutions\NorthwindFoods\DWNorthwindOrders.mdf' 
, SIZE = 10MB 
, MAXSIZE = 1GB
, FILEGROWTH = 10MB )
 LOG ON 
( NAME = N'DWCoffeeMerchantSales_log'
, FILENAME = N'C:\_BISolutions\NorthwindFoods\DWNorthwindOrders_log.LDF' 
, SIZE = 1MB 
, MAXSIZE = 1GB 
, FILEGROWTH = 10MB)
GO
EXEC [DWCoffeeMerchantSales].dbo.sp_changedbowner @loginame = N'SA', @map = false
GO
ALTER DATABASE [DWCoffeeMerchantSales] SET RECOVERY BULK_LOGGED 
GO

-- DimConsumer 
CREATE TABLE [dbo].[DimConsumer](
	[ConsumerSK] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[ConsumerAK] [int] NOT NULL,
	[ConsumerCity] [nvarchar](20) NOT NULL,
	[ConsumerState] [nvarchar](20) NOT NULL,
	[ConsumerZipcode] [nvarchar](10) NOT NULL,
	[ConsumerCreditLimit] [int] NOT NULL,
) 
GO
