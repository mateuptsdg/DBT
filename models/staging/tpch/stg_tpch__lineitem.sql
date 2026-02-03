with source as (

    select * from {{ source('tpch_sample', 'lineitem') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['l_orderkey', 'l_linenumber']) }} as lineitem_id,

        l_orderkey as order_id,
        l_partkey as part_id,
        l_suppkey as supplier_id,

        l_linenumber as line_number,
        l_quantity as quantity,
        l_extendedprice as extended_price,
        l_discount as discount_percentage,
        l_tax as tax_rate,
        
        l_returnflag as return_flag,
        l_linestatus as status_code,

        l_shipdate as ship_date,
        l_commitdate as commit_date,
        l_receiptdate as receipt_date,

        l_shipinstruct as shipping_instructions,
        l_shipmode as shipping_mode,
        l_comment as comment

    from source

)

select * from renamed