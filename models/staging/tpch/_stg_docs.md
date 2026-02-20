{% docs src_table_orders_orderkey %}
Identificador único de la orden (Primary Key). 
Es un número secuencial que identifica unívocamente cada pedido dentro del sistema.
{% enddocs %}

{% docs src_table_orders_custkey %}
Clave foránea (Foreign Key) que vincula la orden con el cliente (CUSTOMER) que la realizó.
Relación N:1 con la tabla de clientes.
{% enddocs %}

{% docs src_table_orders_orderstatus %}
Estado actual de la orden. Según el estándar TPC-H, los valores posibles son:
* **'O'**: Open (Abierta, tiene líneas pendientes).
* **'F'**: Filled (Completada, todas las líneas enviadas).
* **'P'**: Partial (Parcial, algunas líneas enviadas y otras pendientes).
{% enddocs %}

{% docs src_table_orders_totalprice %}
Valor total de la orden en la moneda del sistema.
Representa la suma del `extendedprice` de todas las líneas, incluyendo impuestos y descuentos.
{% enddocs %}

{% docs src_table_orders_orderdate %}
Fecha en la que se realizó el pedido. 
Se utiliza para la partición y filtrado en informes de ventas temporales.
{% enddocs %}

{% docs src_table_orders_orderpriority %}
Prioridad asignada al pedido por el sistema o el cliente. Valores estándar:
* **1-URGENT**
* **2-HIGH**
* **3-MEDIUM**
* **4-NOT SPECIFIED**
* **5-LOW**
{% enddocs %}

{% docs src_table_orders_clerk %}
Identificador del empleado o dependiente (Clerk) que procesó la orden.
Se genera como texto (ej: 'Clerk#000000951').
{% enddocs %}

{% docs src_table_orders_shippriority %}
Prioridad de envío asociada a la orden.
Aunque en el esquema TPC-H estándar suele tener un valor único (0), se mantiene para compatibilidad futura o reglas de negocio específicas.
{% enddocs %}

{% docs src_table_orders_comment %}
Campo de texto libre para comentarios adicionales o notas sobre el pedido.
El contenido se genera aleatoriamente en el dataset TPC-H para simular datos no estructurados.
{% enddocs %}


{% docs src_table_lineitem_orderkey %}
Clave foránea que referencia a la tabla ORDERS (O_ORDERKEY).
Junto con `linenumber`, forma la clave primaria compuesta de esta tabla.
{% enddocs %}

{% docs src_table_lineitem_partkey %}
Clave foránea que referencia a la tabla PART (P_PARTKEY).
Indica qué producto específico se está pidiendo en esta línea.
{% enddocs %}

{% docs src_table_lineitem_suppkey %}
Clave foránea que referencia a la tabla SUPPLIER (S_SUPPKEY).
Indica qué proveedor suministra la pieza para esta línea de pedido específica.
Nota: La combinación (partkey + suppkey) referencia a la tabla PARTSUPP.
{% enddocs %}

{% docs src_table_lineitem_linenumber %}
Número secuencial de la línea dentro de una orden (1, 2, 3...).
Garantiza la unicidad de cada fila junto con `l_orderkey`.
{% enddocs %}

{% docs src_table_lineitem_quantity %}
Cantidad de unidades del producto pedidas en esta línea.
Valor numérico utilizado para calcular el volumen de envío y costes.
{% enddocs %}

{% docs src_table_lineitem_extendedprice %}
Precio base total de la línea (Cantidad * Precio Unitario de la pieza).
No incluye descuentos ni impuestos.
{% enddocs %}

{% docs src_table_lineitem_discount %}
Descuento aplicado a la línea, expresado como fracción decimal (ej: 0.05 para un 5%).
{% enddocs %}

{% docs src_table_lineitem_tax %}
Impuesto aplicado a la línea, expresado como fracción decimal (ej: 0.08 para un 8%).
{% enddocs %}

{% docs src_table_lineitem_returnflag %}
Indicador de devolución de la mercancía. Valores estándar TPC-H (1 carácter):
* **'R'**: Returned (Devuelto).
* **'A'**: Awaiting Return (Esperando devolución).
* **'N'**: No Return (Sin devolución).
{% enddocs %}

{% docs src_table_lineitem_linestatus %}
Estado actual de la línea de pedido. Valores estándar (1 carácter):
* **'O'**: Open (Pendiente de envío o entrega).
* **'F'**: Shipped/Filled (Enviado y completado).
Se corresponde con el estado general de la orden en la tabla ORDERS.
{% enddocs %}

{% docs src_table_lineitem_shipdate %}
Fecha en la que la mercancía fue enviada por el proveedor.
Crucial para análisis de tiempos de entrega y cumplimiento de SLAs.
{% enddocs %}

{% docs src_table_lineitem_commitdate %}
Fecha comprometida de entrega.
Se compara con `l_receiptdate` para determinar si el envío llegó a tiempo.
{% enddocs %}

{% docs src_table_lineitem_receiptdate %}
Fecha real en la que el cliente recibió la mercancía.
{% enddocs %}

{% docs src_table_lineitem_shipinstruct %}
Instrucciones especiales de envío. Valores comunes en TPC-H:
* **'DELIVER IN PERSON'**
* **'COLLECT COD'**
* **'TAKE BACK RETURN'**
* **'NONE'**
{% enddocs %}

{% docs src_table_lineitem_shipmode %}
Modo de transporte utilizado para el envío. Valores estándar (Strings de 10 chars):
* **'AIR'**, **'REG AIR'**
* **'MAIL'**
* **'SHIP'**
* **'TRUCK'**
* **'RAIL'**
* **'FOB'**
{% enddocs %}

{% docs src_table_lineitem_comment %}
Comentarios varios sobre la línea de pedido. Texto generado aleatoriamente en el benchmark.
{% enddocs %}

{% docs src_table_partsupp_partkey %}
Parte de la clave primaria compuesta. Clave foránea que referencia a la tabla PART (P_PARTKEY).
Identifica el producto o pieza específica que está siendo suministrada.
{% enddocs %}

{% docs src_table_partsupp_suppkey %}
Parte de la clave primaria compuesta. Clave foránea que referencia a la tabla SUPPLIER (S_SUPPKEY).
Identifica al proveedor específico que suministra esta pieza.
{% enddocs %}

{% docs src_table_partsupp_availqty %}
Cantidad disponible (stock) de la pieza que mantiene este proveedor específico.
Es un valor entero utilizado para calcular la disponibilidad de inventario.
{% enddocs %}

{% docs src_table_partsupp_supplycost %}
Coste de suministro de la pieza por parte de este proveedor.
Representa el precio de coste para la empresa, no el precio de venta al público (RetailPrice).
{% enddocs %}

{% docs src_table_partsupp_comment %}
Comentarios o notas sobre la relación proveedor-pieza.
Texto generado aleatoriamente en el benchmark para simular cargas de datos no estructurados.
{% enddocs %}

{% docs src_table_customer_custkey %}
Identificador único del cliente (Primary Key).
Es un número secuencial único generado para cada cliente en el sistema (SF*150.000 filas en escala 1).
{% enddocs %}

{% docs src_table_customer_name %}
Nombre del cliente.
Generado como texto variable para identificar a la entidad comercial o individuo.
{% enddocs %}

{% docs src_table_customer_address %}
Dirección física del cliente.
Campo de texto variable utilizado para envíos y facturación.
{% enddocs %}

{% docs src_table_customer_nationkey %}
Clave foránea que referencia a la tabla NATION (N_NATIONKEY).
Vincula al cliente con su país de origen, permitiendo agregaciones geográficas (ej: Región EMEA vs AMERICAS).
{% enddocs %}

{% docs src_table_customer_phone %}
Número de teléfono del cliente.
Generado con un formato específico que incluye el código de país (vinculado a la nación).
{% enddocs %}

{% docs src_table_customer_acctbal %}
Saldo actual de la cuenta del cliente.
Puede ser negativo (indicando deuda) o positivo (crédito a favor).
{% enddocs %}

{% docs src_table_customer_mktsegment %}
Segmento de mercado al que pertenece el cliente.
Valores estandarizados definidos por el benchmark TPC-H:
* **'AUTOMOBILE'**
* **'BUILDING'**
* **'FURNITURE'**
* **'MACHINERY'**
* **'HOUSEHOLD'**
{% enddocs %}

{% docs src_table_customer_comment %}
Comentarios adicionales sobre el cliente.
Texto generado aleatoriamente para simular datos no estructurados en el perfil del cliente.
{% enddocs %}

{% docs src_table_part_partkey %}
Identificador único de la pieza o producto (Primary Key).
Es un número secuencial generado para cada referencia única en el catálogo.
{% enddocs %}

{% docs src_table_part_name %}
Nombre descriptivo de la pieza.
En el benchmark TPC-H, se genera combinando colores y objetos (ej: 'orchid powder', 'green lace').
{% enddocs %}

{% docs src_table_part_mfgr %}
Identificador del fabricante (Manufacturer).
Formato estándar fijo: 'Manufacturer#1', 'Manufacturer#2', etc.
{% enddocs %}

{% docs src_table_part_brand %}
Marca del producto.
Formato estándar fijo: 'Brand#11', 'Brand#12', etc.
Se utiliza frecuentemente para filtrar gamas de productos en las queries de análisis.
{% enddocs %}

{% docs src_table_part_type %}
Tipo o categoría descriptiva del producto.
Es una combinación de tres niveles: Tamaño (STANDARD, PROMO...), Acabado (POLISHED, BRUSHED...) y Material (TIN, NICKEL, STEEL...).
Ejemplo: 'PROMO BURNISHED COPPER'.
{% enddocs %}

{% docs src_table_part_size %}
Tamaño de la pieza (entero).
Utilizado para calcular requisitos de empaquetado o envío. Rango estándar de 1 a 50.
{% enddocs %}

{% docs src_table_part_container %}
Tipo de contenedor o embalaje requerido para la pieza.
Valores típicos en TPC-H:
* **'SM CASE'**, **'SM BOX'**, **'SM PACK'**
* **'MED BAG'**, **'MED BOX'**, **'MED PACK'**
* **'LG CASE'**, **'LG BOX'**, **'LG PACK'**
* **'JUMBO BAG'**, **'JUMBO BOX'**, **'JUMBO PACK'**
* **'WRAP DRUM'**
{% enddocs %}

{% docs src_table_part_retailprice %}
Precio de venta al público sugerido (Retail Price).
Es el precio base antes de que se apliquen descuentos específicos en la línea de pedido.
{% enddocs %}

{% docs src_table_part_comment %}
Comentarios adicionales sobre el producto.
Texto generado aleatoriamente para simular descripciones no estructuradas.
{% enddocs %}

{% docs src_table_supplier_suppkey %}
Identificador único del proveedor (Primary Key).
Número secuencial fijo (SF*10.000 filas) que identifica a cada entidad proveedora en el sistema.
{% enddocs %}

{% docs src_table_supplier_name %}
Nombre del proveedor.
Generado con el formato estándar 'Supplier#000000001'.
{% enddocs %}

{% docs src_table_supplier_address %}
Dirección física del proveedor.
Campo de texto variable utilizado para contacto y logística.
{% enddocs %}

{% docs src_table_supplier_nationkey %}
Clave foránea que referencia a la tabla NATION (N_NATIONKEY).
Vincula al proveedor con su país de operación. Fundamental para análisis de costes regionales (ej: Query 5 del TPC-H).
{% enddocs %}

{% docs src_table_supplier_phone %}
Número de teléfono de contacto.
Incluye código de país derivado de la nación asociada.
{% enddocs %}

{% docs src_table_supplier_acctbal %}
Saldo actual de la cuenta del proveedor en la moneda del sistema.
Refleja la posición financiera; valores altos indican reservas/crédito, valores bajos pueden indicar deuda.
{% enddocs %}

{% docs src_table_supplier_comment %}
Comentarios adicionales sobre el proveedor.
Texto generado aleatoriamente. En el benchmark, a veces contiene palabras clave ('Customer', 'Complaints', 'Recommends') usadas para filtrar calidad en ciertas queries.
{% enddocs %}

{% docs src_table_nation_key %}
Identificador único de la nación (Primary Key).
Es un conjunto fijo de 25 valores (0-24) que representan países específicos en el benchmark.
{% enddocs %}

{% docs src_table_nation_name %}
Nombre del país.
{% enddocs %}

{% docs src_table_nation_regionkey %}
Clave foránea que referencia a la tabla REGION (R_REGIONKEY).
Asocia cada país a una de las 5 regiones continentales definidas.
{% enddocs %}

{% docs src_table_nation_comment %}
Comentarios adicionales sobre la nación.
Texto generado aleatoriamente para simular descripciones variables.
{% enddocs %}

{% docs src_table_region_regionkey %}
Identificador único de la región (Primary Key).
Es un conjunto fijo de 5 valores (0-4) que representan continentes o áreas geográficas grandes.
{% enddocs %}

{% docs src_table_region_name %}
Nombre de la región geográfica.
{% enddocs %}

{% docs src_table_region_comment %}
Comentarios adicionales sobre la región.
Texto de longitud variable generado aleatoriamente.
{% enddocs %}


{% docs src_table_region %}
Contiene las 5 regiones continentales definidas en el estándar TPC-H 
(AFRICA, AMERICA, ASIA, EUROPE, MIDDLE EAST). 
Se utiliza para agrupar naciones y realizar análisis geográficos globales.
{% enddocs %}

{% docs src_table_nation %}
Contiene los 25 países o naciones utilizados en el sistema. 
Cada nación está vinculada a una región específica y sirve de nexo geográfico
 tanto para clientes (`Customer`) como para proveedores (`Supplier`).
{% enddocs %}

{% docs src_table_supplier %}
Representa a los proveedores registrados en el sistema. 
Cada proveedor pertenece a una nación y es responsable de suministrar 
partes (`Part`). Contiene datos de contacto y saldo financiero.
{% enddocs %}

{% docs src_table_part %}
Catálogo maestro de productos o "partes". 
Contiene la información técnica (tamaño, contenedor, marca, fabricante) 
y comercial (precio retail) de cada artículo, independientemente de quién 
lo suministre o si hay stock.
{% enddocs %}

{% docs src_table_partsupp %}
Tabla que gestiona el inventario y coste de suministro. 
Resuelve la relación entre piezas (`Part`) y proveedores (`Supplier`), 
indicando qué proveedor tiene qué pieza, en qué cantidad (`availqty`) y 
a qué coste (`supplycost`).
{% enddocs %}

{% docs src_table_customer %}
Registro maestro de clientes. Incluye datos demográficos, dirección, 
saldo de cuenta (`acctbal`) y el segmento de mercado (`mktsegment`) al 
que pertenecen. Es la entidad que origina las órdenes de compra.
{% enddocs %}

{% docs src_table_orders %}
Registra las cabeceras de los pedidos de compra realizados por 
los clientes. Contiene información general como la fecha del pedido, 
la prioridad, el estado global y el precio total de la orden.
{% enddocs %}

{% docs src_table_lineitem %}
Contiene el detalle granular de cada línea de los pedidos. 
Incluye la cantidad de productos, descuentos aplicados, impuestos, 
fechas de envío/recepción y las instrucciones de devolución. 
Es la tabla principal para calcular métricas de ventas.
{% enddocs %}

