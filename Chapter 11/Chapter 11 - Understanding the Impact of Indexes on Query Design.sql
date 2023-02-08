
/*
Query 1: example of creating an Index on [Fact].[Sale] table at [Customer Key] column
*/

CREATE INDEX [IX_Fact_Sale_CustomerKey] ON [Fact].[Sale] 

( 

[Customer Key] ASC 

) ;

-- Query to check index info
select * from sys.indexes where name='IX_Fact_Sale_CustomerKey'

/*
Query 2: example of droping an Index on [Fact].[Sale] table at [Customer Key] column, we created above
*/

DROP INDEX [IX_Fact_Sale_CustomerKey] ON [Fact].[Sale] ;



 select * from sys.dm_db_index_usage_stats 
 

-- Because we would use this index later in the chapter, lets recreate it
CREATE INDEX [IX_Fact_Sale_CustomerKey] ON [Fact].[Sale] 

( 

[Customer Key] ASC 

) ;


/*
Query 3: example of renaming an Index 
*/

EXEC sp_rename  N'[Fact].[Sale].[IX_Fact_Sale_CustomerKey]', N'IX_Fact_Sale_Customer_Key', N'INDEX'; 

-- Because we would use this index name later in the chapter, lets rename it to its original name IX_Fact_Sale_CustomerKey

EXEC sp_rename  N'[Fact].[Sale].[IX_Fact_Sale_Customer_Key]', N'IX_Fact_Sale_CustomerKey', N'INDEX'; 

/*
Query 4: example of modifying an Index using drop and create
*/

DROP INDEX [IX_Fact_Sale_CustomerKey] ON [Fact].[Sale] ;

CREATE INDEX [IX_Fact_Sale_CustomerKey] ON [Fact].[Sale] 

( 

[Bill To Customer Key] ASC, 

[Customer Key] ASC 

); 

/*
Query 5: example of modifying an Index ALTER INDEX
*/
ALTER INDEX [IX_Fact_Sale_CustomerKey] ON [Fact].[Sale]  

SET ( ALLOW_PAGE_LOCKS = ON, 

STATISTICS_NORECOMPUTE = ON, 

IGNORE_DUP_KEY = OFF 

); 

/*
Query 6: example of creating CLUSTERED INDEX.
*/

CREATE TABLE dbo.[Employee] 
(
    EmployeeID INT NOT NULL IDENTITY(1,1) , 
    Name VARCHAR(25) NOT NULL,
    Manager INT NOT NULL,
    Job TEXT NOT NULL, 
    Salary INT NOT NULL,
    Commission INT,
    HireDate DATE NOT NULL, 
    DeptID INT NOT NULL,
);


CREATE CLUSTERED INDEX [PK_Employee_EmployeeID] ON dbo.[Employee]  
( 
EmployeeID ASC 
); 

--- example creating clustured index with primary key
DROP TABLE dbo.[Employee] 
CREATE TABLE dbo.[Employee] 
(
    EmployeeID INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    Name VARCHAR(25) NOT NULL,
    Manager INT NOT NULL,
    Job TEXT NOT NULL, 
    Salary INT NOT NULL,
    Commission INT,
    HireDate DATE NOT NULL, 
    DeptID INT NOT NULL,
);
/*
Query 7: example of creating NONCLUSTERED INDEX, here NONCLUSTERED keyword is optional as by default sql server creates non clustered index 
*/

CREATE NONCLUSTERED INDEX [IX_Fact_Sale_InvoiceDateKey] ON [Fact].[Sale] 

( 

[Invoice Date Key] ASC 

) ;

/*
Query 8: example of creating UNIQUE INDEX 
*/

 CREATE UNIQUE INDEX [UK_DimensionCity_CityKey] ON [Dimension].[City] 

(  

[City Key] ASC  

) ;
/*
Query 9: example of creating filtered INDEX 
*/

CREATE NONCLUSTERED INDEX [FI_Integration_Order_WWI_Order_ID] ON [Fact].[Order] 

( 

[WWI Order ID] ASC 

) 

WHERE [Order Date Key] >= '2016-01-01'  

AND [Order Date Key] <= '2016-12-31' ;

/*
Query 10: example of creating covering INDEX 
*/
--QUERY to be COVERED 
SELECT [City Key] 

      ,[Customer Key] 

      ,[Salesperson Key] 

      ,AVG([Quantity]) [Avg Quantity] 

      , AVG([Unit Price]) [Avg Unit Price]       

     , SUM([Profit]) TotalProfit 

FROM [Fact].[Sale]  

WHERE [Invoice Date Key] BETWEEN '2013-01-01' AND '2016-01-03'  

GROUP BY [City Key] 

      ,[Customer Key] 

      ,[Salesperson Key] ;

-- CREATE covering INDEX, Because we already have an index  [IX_Fact_Sale_InvoiceDateKey] on [Fact].[Sale] table, we need to first drop [IX_Fact_Sale_InvoiceDateKey] index and then recreate it. This is one example where we have to drop existing index to modify the existing index to add more features like including columns to create covering index. 
DROP INDEX [IX_Fact_Sale_InvoiceDateKey] ON [Fact].[Sale];  

CREATE NONCLUSTERED INDEX [IX_Fact_Sale_InvoiceDateKey] ON [Fact].[Sale]  

 (  

 	[Invoice Date Key] ASC  

 )  

INCLUDE ([City Key]  

       ,[Customer Key]  

       ,[Salesperson Key]  

       ,[Quantity] 

       ,[Unit Price]        

     ,[Profit] 

  ) ;

/*
Query 11: example to compare performance with and without indexes 
*/

CREATE TABLE [dbo].[Sale](
	[Sale Key] [bigint] IDENTITY(1,1) NOT NULL,
	[City Key] [int] NOT NULL,
	[Customer Key] [int] NOT NULL,
	[Bill To Customer Key] [int] NOT NULL,
	[Stock Item Key] [int] NOT NULL,
	[Invoice Date Key] [date] NOT NULL,
	[Delivery Date Key] [date] NULL,
	[Salesperson Key] [int] NOT NULL,
	[WWI Invoice ID] [int] NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[Package] [nvarchar](50) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Unit Price] [decimal](18, 2) NOT NULL,
	[Tax Rate] [decimal](18, 3) NOT NULL,
	[Total Excluding Tax] [decimal](18, 2) NOT NULL,
	[Tax Amount] [decimal](18, 2) NOT NULL,
	[Profit] [decimal](18, 2) NOT NULL,
	[Total Including Tax] [decimal](18, 2) NOT NULL,
	[Total Dry Items] [int] NOT NULL,
	[Total Chiller Items] [int] NOT NULL,
	[Lineage Key] [int] NOT NULL
) ;

DECLARE @times_records INT
SET @times_records = 0
WHILE @times_records <= 100
BEGIN
INSERT INTO [dbo].[Sale]
           ([City Key]
           ,[Customer Key]
           ,[Bill To Customer Key]
           ,[Stock Item Key]
           ,[Invoice Date Key]
           ,[Delivery Date Key]
           ,[Salesperson Key]
           ,[WWI Invoice ID]
           ,[Description]
           ,[Package]
           ,[Quantity]
           ,[Unit Price]
           ,[Tax Rate]
           ,[Total Excluding Tax]
           ,[Tax Amount]
           ,[Profit]
           ,[Total Including Tax]
           ,[Total Dry Items]
           ,[Total Chiller Items]
           ,[Lineage Key])
SELECT 
      [City Key]
      ,[Customer Key]
      ,[Bill To Customer Key]
      ,[Stock Item Key]
      ,[Invoice Date Key]
      ,[Delivery Date Key]
      ,[Salesperson Key]
      ,[WWI Invoice ID]
      ,[Description]
      ,[Package]
      ,[Quantity]
      ,[Unit Price]
      ,[Tax Rate]
      ,[Total Excluding Tax]
      ,[Tax Amount]
      ,[Profit]
      ,[Total Including Tax]
      ,[Total Dry Items]
      ,[Total Chiller Items]
      ,[Lineage Key]
  FROM [WideWorldImportersDW].[Fact].[Sale]
  SET @times_records = @times_records + 1
END;

-- Now lets run below query and note execution time, which was 2 seconds for me on my machine
--start of CTE queries  

;with   

ISODates as (  

SELECT distinct [Date],[ISO Week Number] as [ISOWeekNumber]  

  FROM [Dimension].[Date])  

--separate multiple CTEs with comma  

,DryTotalQuery as (  

SELECT [Invoice Date Key] as DryInvoiceDateKey  

      ,Sum([Total Dry Items]) as DailyTotalDry  

  FROM [dbo].[Sale]  

  WHERE [Invoice Date Key] between '2013-01-01' and '2016-01-03' and [Total Dry Items] <> 0  

  GROUP BY [Invoice Date Key])  

  --separate multiple CTEs with comma  

,ChillerTotalQuery as (  

SELECT [Invoice Date Key] as ChillerInvoiceDateKey  

       ,Sum([Total Chiller Items]) as DailyTotalChiller  

  FROM [dbo].[Sale]  

  WHERE [Invoice Date Key] between '2013-01-01' and '2016-01-03' and [Total Chiller Items] = 0  

  GROUP BY [Invoice Date Key])  

  --end of CTEs  

  --Query selecting from CTEs:  

  SELECT   

   [Date]  

  ,[ISOWeekNumber]  

  ,ISNULL(DailyTotalDry,0) as DailyTotalDry  

  ,ISNULL(DailyTotalChiller,0) as DailyTotalChiller  

  ,ISNULL(DailyTotalDry,0) + ISNULL(DailyTotalChiller,0) as TotalDailyItems  

  FROM ISODates d  

  LEFT OUTER JOIN DryTotalQuery dtq on d.[Date] = dtq.DryInvoiceDateKey  

 LEFT OUTER JOIN ChillerTotalQuery ctq on d.[Date] = ctq.ChillerInvoiceDateKey  

  WHERE d.[Date] between '2013-01-01' and '2016-01-03' 

  ORDER BY [Date]; 

-- Now lets run below query to create index 
CREATE NONCLUSTERED INDEX [IX_Fact_Sale_Invoice_Date_Key]  ON [dbo].[Sale] ([Invoice Date Key],[Total Dry Items]);


-- Now lets run below query again after creating index and note execution time, which was 00 seconds for me on my machine
--start of CTE queries  

;with   

ISODates as (  

SELECT distinct [Date],[ISO Week Number] as [ISOWeekNumber]  

  FROM [Dimension].[Date])  

--separate multiple CTEs with comma  

,DryTotalQuery as (  

SELECT [Invoice Date Key] as DryInvoiceDateKey  

      ,Sum([Total Dry Items]) as DailyTotalDry  

  FROM [dbo].[Sale]  

  WHERE [Invoice Date Key] between '2013-01-01' and '2016-01-03' and [Total Dry Items] <> 0  

  GROUP BY [Invoice Date Key])  

  --separate multiple CTEs with comma  

,ChillerTotalQuery as (  

SELECT [Invoice Date Key] as ChillerInvoiceDateKey  

       ,Sum([Total Chiller Items]) as DailyTotalChiller  

  FROM [dbo].[Sale]  

  WHERE [Invoice Date Key] between '2013-01-01' and '2016-01-03' and [Total Chiller Items] = 0  

  GROUP BY [Invoice Date Key])  

  --end of CTEs  

  --Query selecting from CTEs:  

  SELECT   

   [Date]  

  ,[ISOWeekNumber]  

  ,ISNULL(DailyTotalDry,0) as DailyTotalDry  

  ,ISNULL(DailyTotalChiller,0) as DailyTotalChiller  

  ,ISNULL(DailyTotalDry,0) + ISNULL(DailyTotalChiller,0) as TotalDailyItems  

  FROM ISODates d  

  LEFT OUTER JOIN DryTotalQuery dtq on d.[Date] = dtq.DryInvoiceDateKey  

 LEFT OUTER JOIN ChillerTotalQuery ctq on d.[Date] = ctq.ChillerInvoiceDateKey  

  WHERE d.[Date] between '2013-01-01' and '2016-01-03' 

  ORDER BY [Date]; 


/*
Query 12: query to get list of fragemented indexes with fragmentation in the WideWorldImportersDW databases
*/

SELECT OBJECT_NAME(IND.OBJECT_ID) AS [Table Name], 

IND.NAME AS [Index Name], PS.INDEX_TYPE_DESC AS [Index Type], 

PS.AVG_FRAGMENTATION_IN_PERCENT [Avg Fragmentation] 

FROM SYS.DM_DB_INDEX_PHYSICAL_STATS(DB_ID(), NULL, NULL, NULL, NULL) PS 

INNER JOIN SYS.INDEXES IND 

ON IND.OBJECT_ID = PS.OBJECT_ID 

AND IND.INDEX_ID = PS.INDEX_ID 

WHERE PS.AVG_FRAGMENTATION_IN_PERCENT > 0 

ORDER BY PS.AVG_FRAGMENTATION_IN_PERCENT DESC ;

/*
Query 13: example of rebuilding index on a table
*/

-- rebuild FK_Fact_Sale_City_Key index on the [Fact].[Sale] table 

ALTER INDEX FK_Fact_Sale_City_Key ON [Fact].[Sale] REBUILD; 

--To rebuild all indexes on [Fact].[Sale] table, use below the following statement: 

ALTER INDEX ALL ON [Fact].[Sale] REBUILD; 

--To rebuild all indexes on [Fact].[Sale] table, with online on: 

ALTER INDEX ALL ON [Fact].[Sale] REBUILD WITH (ONLINE = ON); 

/*
Query 14: example of reorganize index on a table
*/

--example to reorganize FK_Fact_Purchase_Date_Key index: 

ALTER INDEX FK_Fact_Purchase_Date_Key ON [Fact].[Purchase] REORGANIZE; 

--To reorganize all indexes on [Fact].[Purchase] table, use below statement: 

ALTER INDEX ALL ON [Fact].[Purchase] REORGANIZE; 


-- Lets Clean up the objects we created during this chapter

DROP INDEX [IX_Fact_Sale_CustomerKey] ON [Fact].[Sale] ;
DROP TABLE dbo.[Employee]  ;
DROP INDEX [IX_Fact_Sale_InvoiceDateKey] ON [Fact].[Sale]  ;
DROP INDEX [UK_DimensionCity_CityKey] ON [Dimension].[City]  ;
DROP INDEX [FI_Integration_Order_WWI_Order_ID] ON [Fact].[Order]  ;
DROP TABLE dbo.[Sale]  ;