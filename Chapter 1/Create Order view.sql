CREATE VIEW [dbo].[v_orders] AS
SELECT Year([Order Date Key]) as [Order Year],
      MONTH([Order Date Key]) as [Order Month],
      COUNT(distinct [Order Key]) as [orders],
      COUNT(distinct [customer Key]) as [Customers]
FROM [WideWorldImportersDW].[Fact].[Order]
GROUP BY Year([Order Date Key]),
         Month([Order Date Key])
