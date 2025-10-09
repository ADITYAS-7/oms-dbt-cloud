{% macro cust_flag(firstOrderDate, lastOrderDate, decimal_places=0) %}
    -- Calculate the number of days between first and last order
    {% set diff_expr %}
        datediff('day', {{ firstOrderDate }}, {{ lastOrderDate }})
    {% endset %}

    case
        when {{ diff_expr }} <= 30 then 'NEW'
        when {{ diff_expr }} <= 180 then 'ACTIVE'
        else 'CHURNED'
    end
{% endmacro %}
