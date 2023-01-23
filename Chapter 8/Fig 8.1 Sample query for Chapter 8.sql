SELECT 
   c.[City],
   c.[Region],
   SUM(s.[Quantity]) as Quanity,
   SUM(s.[Profit]) as Profit
FROM [Fact].[Sale] s
INNER JOIN [Dimension].[City] c
ON s.[City Key] = c.[City Key]
GROUP BY c.[City],
         c.[Region]
