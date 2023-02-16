SELECT TOP(3) FORMAT( [Date], 'd', 'en-US' ) 'US English'
			 ,FORMAT( [Date], 'd', 'en-gb' ) 'British English'
			 ,FORMAT( [Date], 'd', 'de-de' ) 'German'
			 ,FORMAT( [Date], 'd', 'zh-cn' ) 'Chinese Simplified (PRC)'
FROM [Dimension].[Date]