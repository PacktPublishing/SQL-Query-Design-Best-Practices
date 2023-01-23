SELECT YEAR([Invoice Date Key]) as Year
      ,SUM([Quantity]) as "# of items sold"
      ,SUM([Profit]) as profit
      ,SUM([Total Including Tax]) as "total bill with taxes"
  FROM [WideWorldImportersDW].[Fact].[Sale]
  GROUP BY year([Invoice Date Key])
