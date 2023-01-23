  SELECT YEAR([Invoice Date Key]) as Year,
         MIN([Delivery Date Key]) as [Earliest Delivery Date]
  FROM [WideWorldImportersDW].[Fact].[Sale]
  GROUP BY Year([Invoice Date Key])
  ORDER BY Year([Invoice Date Key])
