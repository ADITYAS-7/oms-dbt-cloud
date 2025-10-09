{{config(materialized = 'table')}}

SELECT 

    pm.PaymentType,

    pm.Provider,

    SUM(p.AmountPaid - p.TaxAmount + p.DiscountAmount) AS Net_Revenue,


    SUM(CASE WHEN p.PaymentStatus = 'Failed' THEN 1 ELSE 0 END) AS Failed_Payments,


    COUNT(DISTINCT p.OrderID) AS Total_Orders,

    {{avg('Net_Revenue', 'Total_Orders')}}  as AvgOrderValue --avg is a macro here ;)

FROM 

 {{ source('landing', 'payments') }} p
 JOIN
 {{source("landing",'paymentmethods')}} pm

 ON  p.PaymentMethodID = pm.PaymentMethodID


 GROUP BY

 
pm.PaymentType,
 pm.Provider
