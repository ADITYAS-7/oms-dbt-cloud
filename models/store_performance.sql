{{config(materialized = 'table')}}

SELECT 
O.StoreID,
St.StoreName,
SUM(OI.Quantity) AS Total_Quantity,
SUM(OI.Quantity * OI.UnitPrice) AS Total_Revenue

FROM 

    {{ source('landing', 'stores') }} St 
JOIN
    {{ ref('order_stg') }} O

    ON St.StoreID = O.StoreID

JOIN

    {{ ref('orderitem_stg') }} OI

    ON OI.OrderID = O.OrderID

GROUP BY 

O.StoreID,
St.StoreName


