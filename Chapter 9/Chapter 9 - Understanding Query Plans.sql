
--Chapter - 9 Understanding Query Plans 

-- Query 1: To get sample query plan 

SELECT TOP (1000) * FROM [WideWorldImporters].[Sales].[Customers] ;

-- Query 2: To Display Estimated Execution Plan, Actual Execution Plan and Live Query Statistics 

SELECT TOP (1000) [CityID] 

      ,[CityName] 

      ,[StateProvinceID] 

      ,[Location] 

      ,[LatestRecordedPopulation] 

      ,[LastEditedBy] 

  FROM [WideWorldImporters].[Application].[Cities] ;

  -- Query 3: To Display Estimated Execution Plan in XML format 

SET SHOWPLAN_XML ON;   

GO  

SELECT TOP (1000) [CityID]  

      ,[CityName]  

      ,[StateProvinceID]  

      ,[Location]  

      ,[LatestRecordedPopulation]  

      ,[LastEditedBy]  

  FROM [WideWorldImporters].[Application].[Cities] ; 

GO 

SET SHOWPLAN_XML OFF;   

GO 

  -- Query 4: Example query to diagnose performance issue

SELECT  

      [CityName] 

  FROM [WideWorldImporters]. [Application].[Cities] 

  WHERE CityName='Abbeville' 