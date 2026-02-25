{# --- Utility Macros --- #}

{% docs doc_generate_schema_name %}
Lógica personalizada para la generación de esquemas en dbt.
Controla si los modelos se crean en el esquema target por defecto o en un esquema personalizado 
{% enddocs %}

{% docs doc_pricing %}
Macro de cálculo de precios.
Estandariza la lógica de negocio para calcular precios finales, 
aplicando descuentos e impuestos.
{% enddocs %}

{% docs doc_remove_prefix %}
Utilidad de limpieza de strings.
Elimina prefijos (ej. "customer#", "clerk#") de valores
{% enddocs %}

{% docs doc_to_date_key %}
Generador de claves de fecha (Date Keys).
Convierte una fecha estándar (YYYY-MM-DD) en un entero (YYYYMMDD).
{% enddocs %}

{# --- Generic Tests (Custom Tests) --- #}

{% docs doc_test_is_not_future %}
Test genérico de consistencia temporal.
Valida que una columna de fecha no contenga valores mayores a la fecha actual (futuro).
{% enddocs %}

{% docs doc_test_is_positive %}
Test genérico de validación numérica.
Asegura que los valores de una columna sean estrictamente mayores a cero.
{% enddocs %}