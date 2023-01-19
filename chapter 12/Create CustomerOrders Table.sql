IF EXISTS (SELECT 1 FROM sys.tables where name = 'CustomerOrders')
    DROP TABLE dbo.CustomerOrders;
GO

CREATE TABLE dbo.CustomerOrders
   (CustomerID INT NOT NULL
    ,CustomerName VARCHAR (200) NOT NULL
    ,CustomerOrderHistory VARCHAR (MAX) NOT NULL
   )
;
GO
