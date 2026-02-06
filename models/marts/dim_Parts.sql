with parts as (
    select * from {{ ref('clean_parts') }}
),

final as (
    select
        part_id,
        part_name,
        manufacturer_num,
        brand_num,
        part_type,
        part_size,
        container_type,
        retail_price,
    from parts
)

select * from final