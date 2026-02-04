with customers as (
    select * from {{ ref('stg_tpch__customer') }}
),

nations as (
    select * from {{ ref('stg_tpch__nation') }}
),

regions as (
    select * from {{ ref('stg_tpch__region') }}
),

final as (
    select
        c.customer_id,
        c.customer_name,
        c.address,
        c.phone_number,
        c.account_balance,
        c.market_segment,
        
        -- Información geográfica desnormalizada
        n.nation_name,
        r.region_name,
        
        c.comment

    from customers as c
    left join nations as n 
        on c.nation_id = n.nation_id
    left join regions as r 
        on n.region_id = r.region_id
)

select * from final