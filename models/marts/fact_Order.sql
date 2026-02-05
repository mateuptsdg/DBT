{{
    config(
        materialized='incremental',
        unique_key='lineitem_id',
        on_schema_change='fail'
    )
}}

with orders as (
    select * from {{ ref('stg_tpch__orders') }}
),

line_items as (
    select * from {{ ref('stg_tpch__lineitem') }}
    
    {% if is_incremental() %}
    -- Solo traemos las líneas cuya fecha sea posterior a la última cargada en esta Fact
    where ship_date > (select max(ship_date) from {{ this }})
    {% endif %}
),

final as (
    select
        li.lineitem_id,
        li.order_id,
        li.part_id,
        li.supplier_id,
        o.customer_id,
        
        o.status_code as order_status,
        li.return_flag,
        
        -- Tu macro genérica para limpiar el prefijo
        {{ remove_prefix('o.clerk_name') }} as clerk_id,
        
        {{ calculate_net_amount('li.extended_price', 'li.discount_percentage', 'li.tax_rate') }} as net_item_sales_amount,
        
        li.quantity,
        o.order_date,
        li.ship_date

    from line_items as li
    inner join orders as o 
        on li.order_id = o.order_id 
)

select * from final