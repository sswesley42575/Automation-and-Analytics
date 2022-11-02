CREATE VIEW vwNationwideSilverRaw
AS 
SELECT
    idx
    ,AgencyNumber
    ,NotificationType
    ,DateVal
    ,Insured
    ,BillingAccountNumber
    ,Policy
    ,[Status]
    ,CancelDate
    ,Company
    ,PaymentAcceptanceDate
    ,TotalBalance
    ,MinimumDue
    ,NonSufficientFunds
    ,DateReinstated
    ,CancellationMailed
    ,dateint
FROM 
    OPENROWSET(
        BULK 'silver/nationwide/',
        DATA_SOURCE = 'LakehouseData',
        FORMAT = 'DELTA'
    ) AS [result]