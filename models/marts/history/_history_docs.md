{% docs dim_customers_history %}
**Dimensión Histórica de Clientes**
Vista de negocio construida sobre el snapshot de clientes.
Permite recrear el estado exacto de un cliente en cualquier fecha pasada para reportes retroactivos.
{% enddocs %}

{% docs dim_parts_history %}
**Dimensión Histórica de Partes**
Vista de negocio sobre el snapshot de partes.
Se utiliza para asociar ventas históricas con el precio de lista vigente en el momento de la venta, evitando usar el precio actual incorrectamente.
{% enddocs %}

{% docs dim_suppliers_history %}
**Dimensión Histórica de Proveedores**
Vista de negocio sobre el snapshot de proveedores. Incluye enriquecimiento geográfico histórico.
{% enddocs %}

{% docs fct_stock_history %}
**Tabla de Hechos de Histórico de Stock**
Evolución temporal del valor del inventario.
Permite responder preguntas como: "¿Cuál era el valor total de nuestro stock al cierre del mes pasado?".
{% enddocs %}


{% docs scd_is_current %}
Indicador booleano derivado (`dbt_valid_to IS NULL`) que facilita el filtrado para los usuarios de negocio.
* **True:** Es el registro actualmente vigente (la "foto" de hoy).
* **False:** Es un registro histórico/obsoleto.
{% enddocs %}