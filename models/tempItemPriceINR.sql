SELECT
OrderItemID,
OrderID,
ProductID,
Quantity,
UnitPrice,
Updated_at,
{{unit_price_to_inr('UnitPrice')}} as UnitPriceINR
FROM
{{source("landing","orderitems")}}