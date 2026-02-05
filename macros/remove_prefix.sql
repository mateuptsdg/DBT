{% macro remove_prefix(column_name) %}
    -- Eliminamos el prefijo 'Clerk#' 'Brand#' 'Supplier#' ... y cualquier letra inicial, quedándonos solo con el ID numérico
    regexp_replace({{ column_name }}, '^[a-zA-Z#]+', '')
{% endmacro %}