{% docs doc_assert_order_total_reconciliation %}
Verifica la integridad financiera de la orden.
{% enddocs %}

{% docs doc_assert_shipping_logic %}
Valida que la lógica de envío se cumpla correctamente.
{% enddocs %}

{% docs doc_assert_unit_price_consistency %}
Control de calidad sobre los precios unitarios.
{% enddocs %}

{% docs doc_assert_valid_quantity %}
Sanidad de datos en cantidades.
Asegura que `quantity` sea estrictamente mayor a 0
{% enddocs %}

{% docs doc_assert_positive_pricing %}
Validación de precios de venta.
Este test asegura que no existan registros en los Marts finales con precios de venta negativos o cero
{% enddocs %}

{% docs doc_assert_profit %}
Consistencia del margen de beneficio.
Cualquier desviación aquí indica un problema en la lógica de unión de costos.
{% enddocs %}