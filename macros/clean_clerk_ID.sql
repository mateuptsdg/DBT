{% macro clean_clerk_id(column_name) %}
    -- Eliminamos el prefijo 'Clerk#' y cualquier letra inicial, quedándonos solo con el ID numérico
    regexp_replace({{ column_name }}, '^[a-zA-Z#]+', '')
{% endmacro %}