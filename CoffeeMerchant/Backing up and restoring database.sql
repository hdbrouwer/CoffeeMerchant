BACKUP DATABASE [DWCoffeeMerchantSales]
TO  DISK N'C:\_BISolutions\CoffeeMerchant\DWCoffeeMerchantSales\DWCoffeeMerchantSales_BeforeETL.bak'
WITH INIT
GO

-- Check to see if there is already a database with that name
IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'DWCoffeeMerchantSales')
  BEGIN
  -- If there is, close connections to the DWCoffeeMerchantSales database, with the code below
    ALTER DATABASE [DWCoffeeMerchantSales] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
  END
 
-- Restore the empty database
USE Master
RESTORE DATABASE [DWCoffeeMerchantSales]
FROM DISK =
N'C:\_BISolutions\CoffeeMerchant\DWCoffeeMerchantSales\DWCoffeeMerchantSales_BeforeETL.bak'
WITH REPLACE
GO
