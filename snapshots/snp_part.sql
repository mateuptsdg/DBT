{% snapshot snsh_part %}

{{
    config(
      target_database=target.database,
      target_schema='snapshots',
      unique_key='part_id',
      strategy='check',
      check_cols=['retail_price', 'container_type', 'part_size'],
      invalidate_hard_deletes=True,
      tags=['staging']
    )
}}

with source as (

    select * from {{ source('tpch_sample', 'part') }}

),

renamed as (

    select
        p_partkey as part_id,
        p_name as part_name,
        p_mfgr as manufacturer_name,
        p_brand as brand_name,
        p_type as part_type,
        p_size as part_size,
        p_container as container_type,
        p_retailprice as retail_price,
        p_comment as comment
    from source

)

select * from renamed

{% endsnapshot %}

