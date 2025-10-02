string_not_null.sql
{% test string_not_null(model, column_name)%}
SELECT {{column_name}}
FROM {{model}}
WHERE Trim({{column_name}}) = ''
{%endtest%}
