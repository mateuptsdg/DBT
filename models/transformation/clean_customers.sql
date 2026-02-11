
with customers as (
    select * from {{ ref('stg_tpch__customer') }}
),

final as (
    select
        c.customer_id,
        c.phone_number,
        c.account_balance,
        c.market_segment,
        c.nation_id
    from customers as c
)

select * from final