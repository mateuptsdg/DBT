-- Este test calcula el total real sumando las líneas y lo compara con el total de la orden.
-- Se permite una diferencia mínima (0.01) para evitar fallos por redondeo de decimales.

{{ config(
    severity = 'warn',
    warn_if = '> 0'
) }}

with line_item_totals as (
    select
        l_orderkey,
        sum(
            round(
                round(l_extendedprice * (1 - l_discount) * (1 + l_tax), 2), 
                2
            )
        ) as calculated_total
    from {{ source('tpch_sample', 'lineitem') }}
    group by 1
)

select
    o.o_orderkey,
    o.o_totalprice,
    l.calculated_total,
    abs(o.o_totalprice - l.calculated_total) as difference
from {{ source('tpch_sample', 'orders') }} o
join line_item_totals l on o.o_orderkey = l.l_orderkey
where abs(o.o_totalprice - l.calculated_total) > 0.02