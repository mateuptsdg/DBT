{{config(tags=['mart'])}}
with part_suppliers as (
    select * from {{ ref('clean_partsupp') }}
),

parts as (
    select * from {{ ref('clean_parts') }}
),

final as (
        select 
        {{ dbt_utils.generate_surrogate_key(['ps.part_id', 'ps.supplier_id']) }} as stock_item_key,
        ps.part_id,
        ps.supplier_id,
    
        ps.available_quantity,
        ps.unit_cost,
        p.retail_price as market_retail_price,
        ps.total_stock_value

    from part_suppliers ps
    inner join parts p 
        on ps.part_id = p.part_id
)

select * from final