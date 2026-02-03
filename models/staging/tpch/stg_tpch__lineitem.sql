with source as (

    select * from {{ source('tpch_sample', 'lineitem') }}

),

renamed as (

    select
        -- 1. Llave Primaria Única (Surrogate Key)
        -- Usamos dbt_utils para crear un hash único combinando el ID de orden y el número de línea
        {{ dbt_utils.generate_surrogate_key(['l_orderkey', 'l_linenumber']) }} as lineitem_id,

        -- 2. Llaves Foráneas (FK)
        l_orderkey as order_id,
        l_partkey as part_id,
        l_suppkey as supplier_id,

        -- 3. Atributos de la Línea
        l_linenumber as line_number,
        l_quantity as quantity,
        l_extendedprice as extended_price,
        l_discount as discount_percentage,
        l_tax as tax_rate,
        
        -- 4. Estados y Flags
        l_returnflag as return_flag,
        l_linestatus as status_code,

        -- 5. Fechas
        l_shipdate as ship_date,
        l_commitdate as commit_date,
        l_receiptdate as receipt_date,

        -- 6. Otros
        l_shipinstruct as shipping_instructions,
        l_shipmode as shipping_mode,
        l_comment as comment

    from source

)

select * from renamed