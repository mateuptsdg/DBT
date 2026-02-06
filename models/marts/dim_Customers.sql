{{ config(materialized='table') }}

with customers as (
    select * from {{ ref('stg_tpch__customer') }}
),

-- Reemplazamos 'nations' y 'regions' por tu modelo intermedio unificado
locations as (
    select * from {{ ref('nation_region') }}
),

final as (
    select
        c.customer_id,
        c.phone_number,
        c.account_balance,
        c.market_segment,
        l.nation_name,
        l.region_name
        
    from customers as c
    left join locations as l 
        on c.nation_id = l.nation_id
)

select * from final