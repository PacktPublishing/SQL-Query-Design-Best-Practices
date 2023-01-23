SELECT Year([Order Date Key]) as "Order Year",
       Month([Order Date Key]) as "Order Month",
	 [Order Key] as "Order",
	 [stock item key] as "Stock Item",
	 [Customer Key] as "Customer",
	 [WWI Order ID] as "WWI Order",
	 [WWI Backorder ID] as "WWI Backorder"       
FROM [WideWorldImportersDW].[Fact].[Order]
WHERE [WWI Backorder ID] IS NOT NULL;
