{{ config(materialized='table') }}

with suppliers_snapshot as (
    select * from {{ ref('snsh_supplier') }}
),

locations as (
    select * from {{ ref('nation_region') }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['s_suppkey', 'dbt_valid_from']) }} as supplier_key,
        
        s.s_suppkey as supplier_id,
        {{ remove_prefix('s.s_name') }} as supplier_name,
        s.s_phone as phone_number,
        s.s_acctbal as account_balance,
        l.nation_name as supplier_nation,
        l.region_name as supplier_region,
        dbt_valid_from as valid_from,
        dbt_valid_to as valid_to,
        (dbt_valid_to is null) as is_current

    from suppliers_snapshot as s 
    left join locations as l
        on s.s_nationkey = l.nation_id
)

select * from final