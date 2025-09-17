

{% macro generate_profit_model(table_name) %}
SELECT
  OrderID,
 Quantity * UnitPrice as total_price
 FROM {{ source('landing', table_name) }}
{% endmacro %}