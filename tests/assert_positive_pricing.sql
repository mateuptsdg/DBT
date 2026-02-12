-- el precio que cobramos debe ser positivo
-- puede que cobre irrelevancia con la cantidad > 0 y el pricing correcto
-- Usamos la macro para garantizar que la lógica de redondeo sea la oficial del proyecto
-- Configuramos una severidad de error porque un importe neto negativo es un fallo crítico de negocio
{{ config(severity = 'error') }}

with calculated_amounts as (
    select
        l_orderkey,
        l_linenumber,
        {{ calculate_net_amount('l_extendedprice', 'l_discount', 'l_tax') }} as net_amount
    from {{ source('tpch_sample', 'lineitem') }}
)

select *
from calculated_amounts
where net_amount < 0