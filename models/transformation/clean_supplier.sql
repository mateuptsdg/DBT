with suppliers as (
    select * from {{ ref('stg_tpch__supplier') }}
),
final as (
    select
        s.supplier_id,
        {{ remove_prefix('s.supplier_name') }} as supplier_name,  
        s.phone_number,
        s.account_balance,
        s.nation_id
        from suppliers s)
        
select * from final