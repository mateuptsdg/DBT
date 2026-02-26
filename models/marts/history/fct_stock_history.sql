{{ config(materialized='table') }}

with part_suppliers_snapshot as (
    select * from {{ ref('snp_partsupp') }}
),

parts as (
    select * from {{ ref('dim_parts_history') }}
),

suppliers as (
    select * from {{ ref('dim_supplier_history') }}
),

final as (
    select
        partsupp_id as stock_item_key,
        part_id,
        supplier_id,
        available_quantity,
        supply_cost as unit_cost,
        (available_quantity * supply_cost) as total_stock_value,
        dbt_valid_from as effective_from,
        dbt_valid_to as effective_to,
        case when dbt_valid_to is null then true else false end as is_active_stock

    from part_suppliers_snapshot 
)

select * from final