{% snapshot snsh_partsupp %}

{{
    config(
      target_database=target.database,
      target_schema='snapshots',
      unique_key='partsupp_id',
      strategy='check',
      check_cols=['available_quantity', 'supply_cost'],
      invalidate_hard_deletes=True
    )
}}

with source as (

    select * from {{ source('tpch_sample', 'partsupp') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['ps_partkey', 'ps_suppkey']) }} as partsupp_id,
        ps_partkey as part_id,
        ps_suppkey as supplier_id,
        ps_availqty as available_quantity,
        ps_supplycost as supply_cost,
        ps_comment as comment

    from source

)

select * from renamed

{% endsnapshot %}