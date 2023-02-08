;
with ISODates as (
SELECT distinct [Date]
      ,[ISO Week Number] as [ISOWeekNumber]
  FROM [Dimension].[Date])

SELECT Date, [ISOWeekNumber]
FROM ISODates

GO


