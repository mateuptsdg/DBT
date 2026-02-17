{{ config(materialized='table') }}

with customers_snapshot as (
    select * from {{ ref('snsh_customers') }}
),
locations as (
    select * from {{ ref('nation_region') }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['c_custkey', 'dbt_valid_from']) }} as customer_key,
        c_custkey as customer_id,
        c_phone as phone_number,
        c_acctbal as account_balance,
        c_mktsegment as market_segment,
        l.nation_name
        l.region_name

        dbt_valid_from as valid_from,
        dbt_valid_to as valid_to,
        
        case when dbt_valid_to is null then true else false end as is_current

    from customers_snapshot as c 
    left join location as l 
        on c.nation_id=l.nation_id
)

select * from final