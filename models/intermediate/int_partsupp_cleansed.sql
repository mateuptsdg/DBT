{{config(tags=['transformation'])}}
with part_suppliers as (
    select * from {{ ref('stg_tpch__partsupp') }}
),

final as (
    select
        ps.partsupp_id,
        ps.part_id,
        ps.supplier_id,
        ps.available_quantity as available_quantity,
        ps.supply_cost as unit_cost,
        (ps.available_quantity * ps.supply_cost) as total_stock_value

    from part_suppliers ps
)

select * from final