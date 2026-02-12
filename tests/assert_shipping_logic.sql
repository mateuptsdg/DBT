-- dbt busca FILAS DE ERROR. Si el query devuelve algo, el test FALLA.
select
    l_orderkey,
    o_orderdate,
    l_shipdate,
    l_receiptdate
from {{ source('tpch_sample', 'lineitem') }} l
join {{ source('tpch_sample', 'orders') }} o 
  on l.l_orderkey = o.o_orderkey
where 
    o.o_orderdate > l.l_shipdate 
    or l.l_shipdate > l.l_receiptdate