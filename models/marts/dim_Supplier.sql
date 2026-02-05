with suppliers as (
    select * from {{ ref('stg_tpch__supplier') }}
),

nations as (
    select * from {{ ref('stg_tpch__nation') }}
),

regions as (
    select * from {{ ref('stg_tpch__region') }}
),

final as (
    select
        s.supplier_id,
        s.supplier_name,
        s.address,
        s.phone_number,
        s.account_balance,
        
        -- Geografía del Proveedor
        n.nation_name as supplier_nation,
        r.region_name as supplier_region
        
        

    from suppliers as s
    left join nations as n 
        on s.nation_id = n.nation_id
    left join regions as r 
        on n.region_id = r.region_id
)

select * from final