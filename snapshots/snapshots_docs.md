{% docs snp_customers %}
**Snapshot de Clientes (Raw)**
Captura incremental de cambios (SCD Tipo 2) sobre la tabla de clientes.
Mantiene el historial técnico de cambios en direcciones, teléfonos y saldos.
{% enddocs %}

{% docs snp_parts %}
**Snapshot de Partes (Raw)**
Captura incremental de cambios sobre el catálogo maestro de partes.
Útil para rastrear variaciones históricas de precios de venta (`retail_price`).
{% enddocs %}

{% docs snp_suppliers %}
**Snapshot de Proveedores (Raw)**
Registro histórico técnico de los datos de proveedores.
Permite auditar cambios en cuentas bancarias o ubicaciones geográficas.
{% enddocs %}

{% docs snp_partsupp %}
**Snapshot de Inventario/Proveedores (Raw)**
Historial técnico de la relación Parte-Proveedor.
Crítico para analizar la evolución de costos (`supply_cost`) y niveles de stock (`available_quantity`) en el tiempo.
{% enddocs %}


{% docs scd_valid_from %}
**Fecha de Inicio de Vigencia**
Fecha y hora (Timestamp) en la que esta versión del registro comenzó a ser válida (verdadera) en el sistema.
Generada automáticamente por dbt snapshots.
{% enddocs %}

{% docs scd_valid_to %}
**Fecha de Fin de Vigencia**
Fecha y hora (Timestamp) en la que esta versión del registro dejó de ser válida y fue reemplazada por una nueva.
Si es `NULL`, significa que es la versión actual vigente.
{% enddocs %}