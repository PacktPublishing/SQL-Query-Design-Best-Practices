SELECT TOP(3) [Stock Holding Key]
			  ,[Bin Location] 
			  ,[BinLocationDetailed] =  
					CASE [Bin Location]  
						WHEN 'L-1' THEN 'LowerLevel1' 
						WHEN 'L-2' THEN 'LowerLevel2' 
						WHEN 'L-3' THEN 'LowerLevel3' 
						ELSE 'N/A' 
					END 
			  ,[Target Stock Level] 
FROM [Fact].[Stock Holding]