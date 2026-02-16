select 
    l_orderkey,
    l_quantity
from {{ source('tpch_sample', 'lineitem') }}
where l_quantity <= 0