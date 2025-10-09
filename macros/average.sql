{%macro avg(sum, total, decimal_places = 0 )%}


ROUND({{sum}} / {{total}})


{%endmacro%}