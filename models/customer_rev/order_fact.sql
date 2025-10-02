{{ config(materialized='table') }}    

SELECT
    O.OrderID,
    O.OrderDate,
    O.CustomerID,
    O.EmployeeID,
    O.StoreID,
    O.StatusCD, 
    O.StatusDesc,
    COUNT(DISTINCT O.OrderID) AS OrderCount,
    SUM(OI.TotalPrice) AS Revenue,
FROM
    {{ ref('order_stg') }} O
JOIN
    {{ ref('orderitem_stg') }} OI ON O.OrderID = OI.OrderID

GROUP BY 1,2,3,4,5,6,7