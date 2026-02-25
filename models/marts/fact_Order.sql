{{config(tags=['mart'])}}
with orders as (
    select * from {{ ref('clean_orders')}}
),

line_items as (
    select * from {{ ref('clean_lineitem') }}
    
    {% if is_incremental() %}
    where ship_date > (select max(ship_date) from {{ this }})
    {% endif %}
),

final as (
    select
        li.lineitem_id,
        li.part_id,
        li.supplier_id,
        o.customer_id,
        
        o.order_status,
        li.return_flag,
        
        o.clerk_id,
        li.net_item_sales_amount,
        
        li.quantity,
        o.order_date_key,
        li.ship_date_key

    from line_items as li
    inner join orders as o 
        on li.order_id = o.order_id 
)

select * from final