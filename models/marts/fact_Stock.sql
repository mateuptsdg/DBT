with part_suppliers as (
    select * from {{ ref('stg_tpch__partsupp') }}
),

parts as (
    select * from {{ ref('stg_tpch__part') }}
),

final as (
    select
        -- PK
        {{ dbt_utils.generate_surrogate_key(['ps.part_id', 'ps.supplier_id']) }} as stock_item_key,

        -- FK
        ps.part_id,
        ps.supplier_id,
    
        ps.available_quantity as available_quantity,
        ps.supply_cost as unit_cost,
        p.retail_price as market_retail_price,

        -- Métrica Calculada
        (ps.available_quantity * ps.supply_cost) as total_stock_value

    from part_suppliers ps
    inner join parts p 
        on ps.part_id = p.part_id
)

select * from final