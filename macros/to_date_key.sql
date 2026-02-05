{% macro to_date_key(column_name) %}
    (
        extract(year from {{ column_name }}) * 10000 +
        extract(month from {{ column_name }}) * 100 +
        extract(day from {{ column_name }})
    )::integer
{% endmacro %}