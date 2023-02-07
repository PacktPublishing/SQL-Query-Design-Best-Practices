  SELECT YEAR([Invoice Date Key]) as Year,
         MONTH([Invoice Date Key]) as Mnth,
         AVG([Quantity]) as [Average # of Items Sold]
  From [WideWorldImportersDW].[Fact].[Sale]
  GROUP BY YEAR([Invoice Date Key]),
           MONTH([Invoice Date Key])
  ORDER BY YEAR([Invoice Date Key]),
           MONTH([Invoice Date Key])
