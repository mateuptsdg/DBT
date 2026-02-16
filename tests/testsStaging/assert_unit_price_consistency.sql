select
    l.l_orderkey,
    l.l_partkey,
    l.l_quantity,
    l.l_extendedprice,
    p.p_retailprice,
    (l.l_quantity * p.p_retailprice) as expected_extended_price
from {{ source('tpch_sample', 'lineitem') }} l
join {{ source('tpch_sample', 'part') }} p on l.l_partkey = p.p_partkey
where abs(l.l_extendedprice - (l.l_quantity * p.p_retailprice)) > 0.01