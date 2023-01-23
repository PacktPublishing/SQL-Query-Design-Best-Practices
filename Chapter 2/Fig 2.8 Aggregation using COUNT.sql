  SELECT YEAR([Invoice Date Key]) as Year,
         MONTH([Invoice Date Key]) as Mnth,
         COUNT([Stock Item Key]) as [# of Items Sold]
  FROM [WideWorldImportersDW].[Fact].[Sale]
  GROUP BY YEAR([Invoice Date Key]),
           MONTH([Invoice Date Key])
  ORDER BY YEAR([Invoice Date Key]),
           MONTH([Invoice Date Key])
