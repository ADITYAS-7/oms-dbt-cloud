SELECT OrderID
FROM {{ref('order_fact')}}
WHERE Revenue < 0