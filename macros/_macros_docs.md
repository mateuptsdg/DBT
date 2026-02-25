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

{% docs macro_create_audit_log_table %}
Esta macro es un proceso de **Bootstrap** (inicialización). 
Se ejecuta automáticamente al inicio de cada comando `dbt run` o `dbt build` mediante un hook de tipo `on-run-start`.
Verifica la existencia del esquema de auditoría (por defecto `my_audit_schema`).
Crea la tabla `dbt_log` si no existe, definiendo las columnas necesarias
{% enddocs %}


{% docs macro_log_run_results %}
Esta macro se encarga de la persistencia de metadatos de ejecución. Se ejecuta al finalizar el proceso (`on-run-end`).
Itera sobre el objeto interno de dbt `results`, el cual contiene un arreglo de cada modelo/test ejecutado. Por cada elemento, realiza un `INSERT` en la tabla de logs.
### Campos capturados:
- **Invocation ID:** El identificador único de la corrida.
- **Status:** Permite filtrar modelos que terminaron en `error` o `skipped`.
- **Execution Time:** Crucial para monitorear el rendimiento y costos del Warehouse.
- **Target Context:** Registra qué perfil (`dev`, `prod`) y qué usuario ejecutó el comando.
{% enddocs %}