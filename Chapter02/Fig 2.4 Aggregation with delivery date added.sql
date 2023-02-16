SELECT YEAR([Invoice Date Key]) as Year
      ,([Delivery Date Key]) as [Deliver Date]
	  ,SUM([Quantity]) as [# of items sold]
	  ,SUM([Profit]) as profit
	  ,SUM([Total Including Tax]) as [Total bill with taxes]
FROM [WideWorldImportersDW].[Fact].[Sale]
GROUP BY YEAR([Invoice Date Key])
         ,[Delivery Date Key]
