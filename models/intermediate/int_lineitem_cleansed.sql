{{config(tags=['transformation'])}}
with line_items as (
    select * from {{ ref('stg_tpch__lineitem') }}
    
    {% if is_incremental() %}
    where ship_date > (select max(ship_date) from {{ this }})
    {% endif %}
),

final as (
    select
        li.lineitem_id,
        li.order_id,
        li.part_id,
        li.supplier_id,
        li.return_flag,
        {{ calculate_net_amount('li.extended_price', 'li.discount_percentage', 'li.tax_rate') }} as net_item_sales_amount,
        li.quantity,
        {{ to_date_key('li.ship_date') }} as ship_date_key

    from line_items as li
)

select * from final