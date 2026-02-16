-- el precio que cobramos debe ser positivo
-- puede que cobre irrelevancia con la cantidad > 0 y el pricing correcto
-- Usamos la macro para garantizar que la lógica de redondeo sea la oficial del proyecto
-- Configuramos una severidad de error porque un importe neto negativo es un fallo crítico de negocio
{{ config(severity = 'error') }}

with calculated_amounts as (
    select
        net_item_sales_amount
    from {{ ref("fact_Order") }}
)

select *
from calculated_amounts
where net_item_sales_amount < 0