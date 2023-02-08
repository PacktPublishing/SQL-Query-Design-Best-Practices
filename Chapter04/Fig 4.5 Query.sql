SELECT TOP(10) [City]
			  ,[State Province]
			  ,[Sales Territory]
FROM [Dimension].[City]
WHERE City <> 'Unknown' 