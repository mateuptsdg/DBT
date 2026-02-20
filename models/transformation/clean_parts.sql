{{config(tags=['transformation'])}}
with parts as (
    select * from {{ ref('stg_tpch__part') }}
),

final as (
    select
        part_id,
        part_name,
        {{ remove_prefix('manufacturer_name') }} as manufacturer_num,
        {{ remove_prefix('brand_name') }} as brand_num,
        part_type,
        part_size,
        container_type,
        retail_price,
    from parts
)

select * from final