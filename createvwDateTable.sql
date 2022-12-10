--Create a table of numbers to build a date table dynamically
ALTER VIEW vwDimDate
AS

WITH
  Pass0 as (select 1 as C union all select 1), --2 rows
  Pass1 as (select 1 as C from Pass0 as A, Pass0 as B),--4 rows
  Pass2 as (select 1 as C from Pass1 as A, Pass1 as B),--16 rows
  Pass3 as (select 1 as C from Pass2 as A, Pass2 as B),--256 rows
  Pass4 as (select 1 as C from Pass3 as A, Pass3 as B),--65536 rows
  Tally as (select row_number() over(order by C) as Number from Pass4)

SELECT 
     DATEADD(DAY, Number, '20201231') AS [Date] 
    ,YEAR(DATEADD(DAY, Number, '20201231')) AS [Year]
    ,FORMAT(DATEADD(DAY, Number, '20201231'), 'MMM') AS [Month]
    ,FORMAT(DATEADD(DAY, Number, '20201231'), 'MMM yyyy') AS [Year Month] 
    ,CAST(FORMAT(DATEADD(DAY, Number, '20201231'), 'yyyyMM') AS INT) AS [YearMonthKey]        
    ,MONTH(DATEADD(DAY, Number, '20201231')) AS [MonthKey]
    ,FORMAT(DATEADD(DAY, Number, '20201231'), 'ddd') AS [Weekday]
    ,DATEPART(WEEKDAY, DATEADD(DAY, Number, '20201231')) AS [WeekdayKey]    
FROM Tally
WHERE Number <= 3652
