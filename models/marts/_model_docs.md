{% docs fct_order %}
**Tabla de Hechos de Pedidos (Ventas)**

Esta es la tabla de hechos principal para el análisis de ventas y transacciones.
**Lógica de construcción:**
- **Granularidad:** Nivel de ítem de línea (`lineitem_id`).
- **Unión de Cabecera y Detalle:** Realiza un `INNER JOIN` entre `clean_lineitem` y `clean_orders` para asociar cada producto vendido con su cliente, vendedor (`clerk_id`) y estado de orden correspondientes.
- **Métricas:** Proporciona el `net_item_sales_amount` y la `quantity` para agregaciones financieras.
- **Dimensionamiento Temporal:** Incluye dos claves de fecha (`order_date_key` y `ship_date_key`) para permitir análisis por fecha de venta o fecha de envío.
- **Carga Incremental:** Configurada para procesar únicamente nuevos registros basados en la fecha de envío para optimizar el rendimiento.
{% enddocs %}

{% docs fct_stock %}
**Tabla de Hechos de Inventario (Stock)**

Esta tabla proporciona una visión consolidada del inventario actual por producto y proveedor.
**Lógica de construcción:**
- **Identificación Única:** Genera `stock_item_key` mediante un hash de `part_id` y `supplier_id`, facilitando el seguimiento de registros únicos de stock.
- **Enriquecimiento de Precios:** Realiza un `INNER JOIN` con `clean_parts` para traer el `retail_price` (como `market_retail_price`), permitiendo comparar el costo de adquisición frente al precio de mercado.
- **Métricas de Valor:** Mantiene el `total_stock_value` calculado para análisis de activos circulantes y valoración de almacén.
{% enddocs %}

{% docs dim_supplier %}
**Dimensión de Proveedores (Enriquecida)**

Esta tabla consolida la información de los proveedores con su contexto geográfico completo.
**Transformaciones clave:**
- **Join de Localización:** Une los datos de proveedores con `nation_region` para incluir nombres legibles de países y regiones.
- **Normalización de Nombres:** Utiliza los nombres de proveedores ya limpios de la capa de transformación.
- **Propósito:** Facilitar el análisis de rendimiento de proveedores por región geográfica y la gestión de saldos de cuenta (`account_balance`).
{% enddocs %}

{% docs dim_parts %}
**Dimensión de Partes (Productos)**

Tabla maestra que contiene el catálogo de productos o partes.
**Lógica de negocio:**
- **Atributos Limpios:** Utiliza los campos `manufacturer_num` y `brand_num` ya procesados en la capa de transformación para facilitar agrupaciones analíticas.
- **Categorización:** Incluye dimensiones críticas como `part_type` y `container_type` para análisis de logística y segmentación de inventario.
{% enddocs %}

{% docs dim_date %}
**Dimensión de Tiempo (Calendario)**

Tabla generada estáticamente para facilitar el análisis temporal en el Data Warehouse.
**Transformaciones y lógica:**
- **Generación Dinámica:** Utiliza la macro `dbt_utils.date_spine` para crear una secuencia de días desde 1990 hasta 2030.
- **Clave Subrogada:** Genera `date_key` usando la macro `to_date_key` para asegurar la compatibilidad con las claves foráneas de las tablas de hechos (`fact_Order`, `fact_Stock`).
- **Atributos Temporales:** Extrae componentes básicos (día, mes, año) para evitar cálculos costosos en las herramientas de visualización.
{% enddocs %}

{% docs dim_customers %}
**Dimensión de Clientes (Enriquecida)**

Esta tabla representa la entidad final de clientes para negocio. 
**Transformaciones y uniones:**
- **Enriquecimiento Geográfico:** Realiza un `LEFT JOIN` entre la tabla limpia de clientes y `nation_region` para aplanar la jerarquía de localización.
- **Atributos incluidos:** Proporciona directamente el nombre de la nación y la región, eliminando la necesidad de que el usuario final trabaje con claves técnicas (`nation_id`).
- **Uso:** Ideal para segmentación de mercado por zona geográfica y análisis de balances de cuenta.
{% enddocs %}

