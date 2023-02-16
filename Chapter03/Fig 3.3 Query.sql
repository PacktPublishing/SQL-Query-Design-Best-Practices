SELECT TOP(3) FORMAT([Quantity],'D','fr-FR' ) 'Quantity'
			 ,FORMAT([Unit Price],'C','fr-FR' ) 'Unit Price'
			 ,FORMAT([Tax Rate]/100, 'P', 'fr-FR') 'Tax Rate'
FROM [Fact].[Sale] 