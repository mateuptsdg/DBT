with source as (

    select * from {{ source('tpch_sample', 'supplier') }}

),

renamed as (

    select
        -- Llaves (PK y FK)
        s_suppkey as supplier_id,
        s_nationkey as nation_id,

        -- Atributos del Proveedor
        s_name as supplier_name,
        s_address as address,
        s_phone as phone_number,
        s_acctbal as account_balance,
        s_comment as comment

    from source

)

select * from renamed