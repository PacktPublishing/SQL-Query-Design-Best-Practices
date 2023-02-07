SELECT [Invoice Date Key]
      ,[Delivery Date Key]
      ,SUM([Quantity]) as "# of items sold"
      ,SUM([Profit]) as profit
      ,SUM ([Total Including Tax]) as "total bill with taxes"
  FROM [WideWorldImportersDW].[Fact].[Sale]
  GROUP BY [Invoice Date Key], [Delivery Date Key]
