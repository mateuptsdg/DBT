-- Se define la carga incremental, aunque para ser realistas (y conectarlo a un Streamlit) esta base de datos tendria
-- que ser capaz de actualizarse al momento, es por eso que se podria definir las tablas como tablas dinámicas
-- En este caso, al ser tablas predefinidas de snowflake, da poco juego (no se deben poder hacer inserts a esa BBDD)

with orders as (
    select * from {{ ref('clean_orders') }}
),

line_items as (
    select * from {{ ref('clean_lineitem') }}
    
    {% if is_incremental() %}
    -- Solo traemos las líneas cuya fecha sea posterior a la última cargada en esta Fact
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