with part_suppliers as (
    select * from {{ ref('stg_tpch__partsupp') }}
),

parts as (
    select * from {{ ref('stg_tpch__part') }}
),

final as (
    select
        -- Llave Primaria Técnica (PK)
        {{ dbt_utils.generate_surrogate_key(['ps.part_id', 'ps.supplier_id']) }} as stock_item_key,

        -- Llaves Foráneas (FK)
        ps.part_id,
        ps.supplier_id,
        
        -- Métricas de Stock
        ps.available_quantity as available_quantity,
        ps.supply_cost as unit_cost,
        
        -- Métrica Calculada: Valor total del stock para este producto/proveedor
        (ps.available_quantity * ps.supply_cost) as total_stock_value,

        -- Atributos de apoyo (opcional, para facilitar el BI)
        p.retail_price as market_retail_price

    from part_suppliers as ps
    inner join parts as p 
        on ps.part_id = p.part_id
)

select * from final