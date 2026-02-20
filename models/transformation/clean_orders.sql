{{config(tags=['transformation'])}}
with orders as (
    select * from {{ ref('stg_tpch__orders') }}
),
final as (
    select
        o.customer_id,
        o.order_id,
        o.status_code as order_status,
        {{ remove_prefix('o.clerk_name') }} as clerk_id,
        {{ to_date_key('o.order_date') }} as order_date_key,

    from orders o
)

select * from final