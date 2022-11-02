CREATE VIEW vwUPCSilverRaw
AS 
SELECT
     PolicyNumber
    ,Insured
    ,[Description]
    ,DateSent
FROM 
    OPENROWSET(
        BULK 'silver/upcsilver_raw/',
        DATA_SOURCE = 'LakehouseData',
        FORMAT = 'DELTA'
    ) AS [result]