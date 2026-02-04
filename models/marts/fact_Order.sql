with orders as (
    select * from {{ ref('stg_tpch__orders') }}
),

line_items as (
    select * from {{ ref('stg_tpch__lineitem') }}
),

final as (
    select
        line_items.lineitem_id,
        
        -- Dimensiones (FK)
        orders.order_id,
        orders.customer_id,
        line_items.part_id,
        line_items.supplier_id,
        
        -- Atributos de la orden (Contexto)
        orders.status_code as order_status,
        orders.clerk_name,  -- Tu ID de "agente" de ventas
        
        -- Fechas (Crucial para el análisis temporal que buscabas)
        orders.order_date,
        line_items.ship_date,
        line_items.commit_date,
        line_items.receipt_date,
        
        -- Métricas (Hechos para sumar)
        line_items.quantity,
        line_items.extended_price,
        line_items.discount_percentage,
        line_items.tax_rate,
        
        -- Cálculo de valor de negocio
        round((line_items.extended_price * (1 - line_items.discount_percentage)), 2) as net_item_sales_amount

    from line_items
    inner join orders on line_items.order_id = orders.order_id
)

select * from final