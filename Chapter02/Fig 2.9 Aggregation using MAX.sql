  SELECT [Invoice Date Key],
         MAX([Quantity]) as [# of Items Sold]
  FROM [WideWorldImportersDW].[Fact].[Sale]
  GROUP BY [Invoice Date Key]
  ORDER BY [Invoice Date Key]

