{{ config(materialized='table') }}

SELECT
    OI.ProductID,
    P.Name,
    P.Category,
    SUM(OI.Quantity) AS Total_Quantity,
    SUM(OI.Quantity * OI.UnitPrice) AS Total_Revenue
FROM
    {{ source('landing', 'products') }} P
JOIN
    {{ ref('orderitem_stg') }} OI
    ON OI.ProductID = P.ProductID
GROUP BY
    OI.ProductID,
    P.Name,
    P.Category
