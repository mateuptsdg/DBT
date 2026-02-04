-- el precio que cobramos debe ser positivo
-- puede que cobre irrelevancia con la cantidad > 0 y el pricing correcto
-- Usamos la macro para garantizar que la lógica de redondeo sea la oficial del proyecto
select
    l_orderkey,
    l_linenumber,
    {{ calculate_net_amount('l_extendedprice', 'l_discount', 'l_tax') }} as net_amount
from {{ source('tpch_sample', 'lineitem') }}
where {{ calculate_net_amount('l_extendedprice', 'l_discount', 'l_tax') }} < 0