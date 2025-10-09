{{ config(materialized='table') }}

SELECT
    O.CustomerID,
    C.CustomerName,
    MIN(O.Orderdate) AS FirstOrderDate,
    MAX(O.Orderdate) AS LastOrderDate,
    COUNT(O.OrderID) AS OrdersByCustomer,
    {{cust_flag('min(Orderdate)', 'max(Orderdate)')}} as Customer_Status -- Calling the flag Macro 

    
FROM
    {{ ref('order_stg') }} O
JOIN
    {{ ref('customer_stg') }} C ON O.CustomerID = C.CustomerID
GROUP BY
    O.CustomerID,
    C.CustomerName










