with orders as (
    select * from {{ ref('stg_tpch__orders') }}
),

line_items as (
    select * from {{ ref('stg_tpch__lineitem') }}
),

final as (
    select
        -- Usamos los nombres nuevos que definiste en el Staging
        li.lineitem_id,
        li.order_id,
        li.part_id,
        li.supplier_id,
        o.customer_id,
        
        o.status_code as order_status,
        li.return_flag,
        
        -- Aplicamos las macros con los nombres nuevos
        {{ clean_clerk_ID('o.o_clerk') }} as clerk_id,
        
        {{ calculate_net_amount('li.extended_price', 'li.discount_percentage', 'li.tax_rate') }} as net_item_sales_amount,
        
        li.quantity,
        o.order_date,
        li.ship_date

    from line_items as li
    inner join orders as o 
        on li.order_id = o.order_id 
)

select * from final