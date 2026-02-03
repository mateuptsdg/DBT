with source as (

    select * from {{ source('tpch_sample', 'nation') }}

),

renamed as (

    select
        -- Llaves (PK y FK)
        n_nationkey as nation_id,
        n_regionkey as region_id,

        -- Atributos
        n_name as nation_name,
        n_comment as comment

    from source

)

select * from renamed