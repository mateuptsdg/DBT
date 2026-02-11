{% macro calculate_net_amount(extended_price, discount_val, tax_val=0) %}
    -- Lógica: (Precio * (1 - Descuento)) * (1 + Impuesto)
    -- El valor por defecto de tax_val es 0 por si solo quieres el neto sin tasas.
    round(
        round({{ extended_price }} * (1 - {{ discount_val }}), 2) * (1 + {{ tax_val }}),
        2
    )
{% endmacro %}