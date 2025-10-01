
{{ config(materialized='table') }}




SELECT 
ProductID,
NAME AS ProductName,
CATEGORY AS Product_Category,
(RETAILPRICE - SUPPLIERPRICE) AS Profit_PP

FROM

{{source('landing', 'products')}}