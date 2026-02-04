with orders as (
    select * from {{ ref('stg_tpch__orders') }}
),

line_item as (
    select * from {{ ref('stg_tpch__lineitem') }}
),

final as (
    select
        -- Llaves (Surrogate Keys o Natural Keys)
        line_item.l_orderkey as order_key,
        line_item.l_partkey as part_key,
        line_item.l_suppkey as supplier_key,
        line_item.l_linenumber as line_number,
        
        -- Dimensiones Degeneradas y Atributos
        orders.o_orderstatus as order_status,
        line_item.l_returnflag as return_flag,
        line_item.l_linestatus as line_status,
        orders.o_clerk as clerk_id
        
        -- Métricas de Negocio usando Macros
        line_item.l_quantity as quantity,
        line_item.l_extendedprice as gross_item_sales_amount,
        
        {{ calculate_net_amount('line_item.l_extendedprice', 'line_item.l_discount') }} as discounted_item_sales_amount,
        
        {{ calculate_net_amount('line_item.l_extendedprice', 'line_item.l_discount', 'line_item.l_tax') }} as net_item_sales_amount,
        
        -- Fechas
        orders.o_orderdate as order_date,
        line_item.l_shipdate as ship_date

    from line_item
    inner join orders 
        on line_item.l_orderkey = orders.o_orderkey
)

select * from final