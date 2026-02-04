with parts as (
    select * from {{ ref('stg_tpch__part') }}
),

final as (
    select
        part_id,
        part_name,
        manufacturer_name,
        brand_name,
        part_type,
        part_size,
        container_type,
        retail_price,
        comment
    from parts
)

select * from final