--start of CTE queries
;with 
ISODates as (
SELECT distinct [Date]
      ,[ISO Week Number] as [ISOWeekNumber]
  FROM [Dimension].[Date])

--separate multiple CTEs with comma
,DryTotalQuery as (
SELECT [Invoice Date Key] as DryInvoiceDateKey
      ,Sum([Total Dry Items]) as DailyTotalDry
  FROM [Fact].[Sale]
  WHERE [Total Dry Items] <> 0
  GROUP BY [Invoice Date Key])

  --separate multiple CTEs with comma
,ChillerTotalQuery as (
SELECT [Invoice Date Key] as ChillerInvoiceDateKey
      ,Sum([Total Chiller Items]) as DailyTotalChiller
  FROM [Fact].[Sale]
  WHERE [Total Chiller Items] <> 0
  GROUP BY [Invoice Date Key])

  --end of CTEs

  --Query selecting from CTEs:
  SELECT 
    [Date]
  , [ISOWeekNumber]
  , ISNULL(DailyTotalDry,0) as DailyTotalDry
  , ISNULL(DailyTotalChiller,0) as DailyTotalChiller
  , ISNULL(DailyTotalDry,0) + ISNULL(DailyTotalChiller,0) as TotalDailyItems
  FROM ISODates d
  LEFT OUTER JOIN DryTotalQuery dtq on d.[Date] = dtq.DryInvoiceDateKey
  LEFT OUTER JOIN ChillerTotalQuery ctq on d.[Date] = ctq.ChillerInvoiceDateKey
  WHERE YEAR(d.Date) = 2016
  ORDER BY [Date]
--try to reuse CTE: will fail
  SELECT * FROM ISODates