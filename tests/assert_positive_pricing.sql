-- el precio que cobramos debe ser positivo
-- puede que cobre irrelevancia con la cantidad > 0 y el pricing correcto
select
    l_orderkey,
    l_linenumber,
    (l_extendedprice * (1 - l_discount) * (1 + l_tax)) as net_amount
from {{ source('tpch_sample', 'lineitem') }}
where (l_extendedprice * (1 - l_discount) * (1 + l_tax)) < 0