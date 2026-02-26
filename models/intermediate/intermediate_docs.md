{% docs clean_customers %}
**Tabla de Clientes Limpia**

Esta tabla contiene la información base de los clientes. 
**Transformaciones aplicadas:**
- **Selección de columnas:** Se han filtrado las columnas relevantes de la capa de staging (`stg_tpch__customer`), descartando campos de texto libre o comentarios no estructurados para optimizar el rendimiento.
- **Normalización:** Se mantienen las claves foráneas como `nation_id` para permitir la integración con modelos geográficos.
{% enddocs %}

{% docs clean_lineitem %}
**Tabla de Detalles de Pedidos (Line Items)**

Contiene el detalle granular de cada línea de pedido.
**Transformaciones aplicadas:**
- **Cálculo de Importe Neto:** Se genera la columna `net_item_sales_amount` aplicando impuestos y descuentos al precio extendido mediante la macro `calculate_net_amount`.
- **Generación de Claves de Fecha:** Se transforma la fecha de envío (`ship_date`) en una clave numérica (`ship_date_key`) usando la macro `to_date_key` para facilitar uniones con dimensiones de tiempo.
- **Lógica Incremental:** Incluye filtrado incremental para procesar solo registros nuevos basados en la `ship_date`.
{% enddocs %}

{% docs clean_orders %}
**Tabla de Cabecera de Pedidos**

Representa la información a nivel de pedido (orden).
**Transformaciones aplicadas:**
- **Estandarización de Estados:** Renombrado de `status_code` a `order_status` para mayor claridad semántica.
- **Limpieza de Identificadores:** Se utiliza la macro `remove_prefix` sobre el campo `clerk_name` para extraer y limpiar el `clerk_id`, eliminando prefijos de texto innecesarios.
- **Generación de Claves de Fecha:** Transformación de la fecha de pedido en `order_date_key` para modelado dimensional.
{% enddocs %}

{% docs clean_parts %}
**Tabla Maestra de Productos/Partes**

Catálogo de partes y productos disponibles.
**Transformaciones aplicadas:**
- **Limpieza de Cadenas:** Uso intensivo de la macro `remove_prefix` para limpiar los campos `manufacturer_name` y `brand_name`, generando los identificadores `manufacturer_num` y `brand_num` respectivamente.
- **Renombrado:** Selección y estandarización de nombres de columnas para tipos y contenedores.
{% enddocs %}

{% docs clean_partsupp %}
**Tabla de Relación Parte-Proveedor**

Tabla intermedia que conecta productos con sus proveedores y disponibilidad.
**Transformaciones aplicadas:**
- **Enriquecimiento de Datos:** Se calcula una nueva métrica `total_stock_value` multiplicando la cantidad disponible (`available_quantity`) por el costo unitario (`supply_cost`).
- **Renombrado Semántico:** Se renombra `supply_cost` a `unit_cost` para reflejar mejor que es el costo por unidad.
{% enddocs %}

{% docs clean_supplier %}
**Tabla de Proveedores**

Directorio de proveedores registrados.
**Transformaciones aplicadas:**
- **Limpieza de Nombres:** Se aplica la macro `remove_prefix` al campo `supplier_name` para eliminar prefijos estandarizados (ej. "Supplier#001" -> "001" o limpieza de caracteres especiales) y obtener un nombre limpio.
- **Selección:** Filtrado de atributos clave como teléfono y saldo de cuenta.
{% enddocs %}

{% docs nation_region %}
**Dimensión Geográfica (Nación y Región)**

Vista desnormalizada que combina información de naciones y regiones.
**Transformaciones aplicadas:**
- **Desnormalización (Join):** Se realiza un `LEFT JOIN` entre las tablas `nation` y `region` para aplanar la jerarquía geográfica.
- **Simplificación:** Permite consultar el nombre de la nación y su región correspondiente (`region_name`) sin necesidad de hacer joins adicionales en los modelos downstream.
{% enddocs %}