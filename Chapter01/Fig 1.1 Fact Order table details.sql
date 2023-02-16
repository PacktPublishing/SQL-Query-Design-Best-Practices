SELECT Table_name as [Table] , 
       Column_name as [Column] , 
       Table_catalog as [Database], 
       Table_schema as [Schema]  
FROM information_schema.columns
Where Table_schema = 'fact'
AND Table_name = 'Order'
ORDER BY Table_name, Column_name; 
