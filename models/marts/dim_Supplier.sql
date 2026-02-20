{{ config(materialized='table', tags=['mart'])}}

with suppliers as (
    select * from {{ ref('clean_supplier') }}
),
locations as (
    select * from {{ ref('nation_region') }} 
),

final as (
    select
        s.supplier_id,
        s.supplier_name,
        s.phone_number,
        s.account_balance,
        l.nation_name as supplier_nation,
        l.region_name as supplier_region
        
    from suppliers s
    left join locations l 
        on s.nation_id = l.nation_id
)

select * from final