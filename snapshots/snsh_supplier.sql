{% snapshot snsh_supplier %}

{{
    config(
      target_schema='snapshots',
      unique_key='s_suppkey',
      strategy='check',
      check_cols=['s_address', 's_phone', 's_acctbal','s_nationkey'],
      invalidate_hard_deletes=True
    )
}}

select 
    s_suppkey,
    s_name,
    s_address,
    s_nationkey,
    s_phone,
    s_acctbal
from {{ source('tpch_sample', 'supplier') }}

{% endsnapshot %}