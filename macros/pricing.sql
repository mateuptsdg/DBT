{% macro calculate_net_amount(extended_price, discount_val, tax_val=0) %}
    round(
        round({{ extended_price }} * (1 - {{ discount_val }}), 2) * (1 + {{ tax_val }}),
        2
    )
{% endmacro %}