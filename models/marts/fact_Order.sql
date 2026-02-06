-- Se define la carga incremental, aunque para ser realistas (y conectarlo a un Streamlit) esta base de datos tendria
-- que ser capaz de actualizarse al momento, es por eso que se podria definir las tablas como tablas dinámicas
-- En este caso, al ser tablas predefinidas de snowflake, da poco juego (no se deben poder hacer inserts a esa BBDD)

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
        
        {{ remove_prefix('o.clerk_name') }} as clerk_id,
        {{ calculate_net_amount('li.extended_price', 'li.discount_percentage', 'li.tax_rate') }} as net_item_sales_amount,
        
        li.quantity,
        {{ to_date_key('o.order_date') }} as order_date_key,
        {{ to_date_key('li.ship_date') }} as ship_date_key

    from line_items as li
    inner join orders as o 
        on li.order_id = o.order_id 
)

select * from final