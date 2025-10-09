{{config(materialized = 'table')}}


SELECT

o.CustomerID,

COUNT(DISTINCT p.OrderID) AS Total_Orders,

SUM(p.AmountPaid - p.TaxAmount + p.DiscountAmount) AS Total_Spent,

{{avg('Total_Spent', 'Total_Orders')}} as AvgOrderValue,   --avg is the macro

pm.PaymentType,

MAX(PaymentDate) AS LastPaymentDate





FROM

{{ ref('order_stg') }} o

JOIN 

 {{ source('landing', 'payments') }} p

 ON p.OrderID = o.OrderID

 
 JOIN
 {{source("landing",'paymentmethods')}} pm

 ON  p.PaymentMethodID = pm.PaymentMethodID


 GROUP BY
 o.CustomerID,
pm.PaymentType
