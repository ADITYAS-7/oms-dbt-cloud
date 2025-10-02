{%macro unit_price_to_inr(UnitPrice, decimal_places = 0)%}
ROUND({{UnitPrice}} * 50)
{%endmacro%}