SELECT TOP(3) FORMAT( [Date], 'D', 'en-US' ) 'US English'
			 ,FORMAT( [Date], 'D', 'en-gb' ) 'British English'
			 ,FORMAT( [Date], 'D', 'de-de' ) 'German'
			 ,FORMAT( [Date], 'D', 'zh-cn' ) 'Chinese Simplified (PRC)'
FROM [Dimension].[Date] 