with source as (

    select * from {{ source('tpch_sample', 'partsupp') }}

),

renamed as (

    select
        -- 1. Llave Primaria Única (Surrogate Key)
        -- Al igual que en lineitem, creamos una llave única para dbt
        {{ dbt_utils.generate_surrogate_key(['ps_partkey', 'ps_suppkey']) }} as partsupp_id,

        -- 2. Llaves Foráneas (FK)
        ps_partkey as part_id,
        ps_suppkey as supplier_id,

        -- 3. Atributos de Inventario
        ps_availqty as available_quantity,
        ps_supplycost as supply_cost,
        ps_comment as comment

    from source

)

select * from renamed