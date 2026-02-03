with source as (

    select * from {{ source('tpch_sample', 'region') }}

),

renamed as (

    select
        -- Llave Primaria
        r_regionkey as region_id,

        -- Atributos
        r_name as region_name,
        r_comment as comment

    from source

)

select * from renamed