{{
    config(
        materialized='view',
        tags='transformation' 
    )
}}
-- Nation al final ya tiene una key unica para cada nacion, asi que se prescinde de regionkey
with nation as (
    select * from {{ ref('stg_tpch__nation') }}
),

region as (
    select * from {{ ref('stg_tpch__region') }}
),

final as (
    select 
        n.nation_id, 
        n.nation_name,
        r.region_name
    from nation n 
    left join region r
        on n.region_id = r.region_id
)

select * from final