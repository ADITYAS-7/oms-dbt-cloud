{{config(materialized ='table')}}


with payments as (

SELECT 
p.OrderID,
        p.PaymentMethodID,
        p.PaymentDate,
        p.AmountPaid,
        p.TaxAmount,
        p.DiscountAmount,
        p.PaymentStatus,
        pm.PaymentType,
        pm.Provider

FROM 

 {{ source('landing', 'payments') }} p
 JOIN
 {{source("landing",'paymentmethods')}} pm

 ON  p.PaymentMethodID = pm.PaymentMethodID


),

 
orders AS (
    SELECT 
        o.OrderID,
        o.StoreID,
        o.CustomerID
     FROM {{ref("order_stg")}} o


),

stores as (
    SELECT 
        s.StoreID,
        s.StoreName
    FROM {{ source('landing', 'stores') }} s
)



SELECT
    s.StoreName,
    pm.PaymentType,
    DATE_TRUNC('month', p.PaymentDate) AS Month,
    COUNT(DISTINCT p.OrderID) AS Total_Orders,
    SUM(p.AmountPaid) AS Total_Amount,
    SUM(p.TaxAmount) AS Total_Tax,
    SUM(p.DiscountAmount) AS Total_Discount,
    SUM(p.AmountPaid - p.TaxAmount + p.DiscountAmount) AS Net_Revenue,
    SUM(CASE WHEN p.PaymentStatus = 'Completed' THEN 1 ELSE 0 END) AS Successful_Payments,
    SUM(CASE WHEN p.PaymentStatus = 'Failed' THEN 1 ELSE 0 END) AS Failed_Payments
FROM payments p
JOIN orders o ON p.OrderID = o.OrderID
JOIN stores s ON o.StoreID = s.StoreID
JOIN {{ source('landing', 'paymentmethods') }} pm ON p.PaymentMethodID = pm.PaymentMethodID
GROUP BY 
    s.StoreName,
    pm.PaymentType,
    DATE_TRUNC('month', p.PaymentDate)
ORDER BY 
    Month DESC, 
    Total_Amount DESC


