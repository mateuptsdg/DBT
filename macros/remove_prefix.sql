{% macro remove_prefix(column_name) %}
    regexp_replace({{ column_name }}, '^[a-zA-Z#]+', '')
{% endmacro %}