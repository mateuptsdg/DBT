{% snapshot snsh_customer %}
{{config(tags=['staging'])}}
{{
    config(
      target_database=target.database,
      target_schema='snapshots',
      unique_key='c_custkey',
      strategy='check',
      check_cols=['c_address', 'c_phone', 'c_acctbal', 'c_mktsegment','c_nationkey'],
      invalidate_hard_deletes=True
    )
}}

select 
    c_custkey,
    c_name,
    c_address,
    c_nationkey,
    c_phone,
    c_acctbal,
    c_mktsegment,
    c_comment
from {{ source('tpch_sample', 'customer') }}

{% endsnapshot %}