SELECT [Order Year],
       [Order Month],
	  COUNT([WWI Backorder]) as "number of backorders",   
	  COUNT([customer]) as "number of impacted customers",
	  COUNT([Order]) as "number of orders"    
FROM v_backorders
GROUP BY [Order Year],
	    [Order Month];
