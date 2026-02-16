with snapshot_parts as (
    -- Llamamos directamente al snapshot que creamos antes
    select * from {{ ref('snsh_parts') }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['part_id', 'dbt_valid_from']) }} as part_key,
        
        part_id,
        part_name,
        manufacturer_name,
        brand_name,
        retail_price,
        dbt_valid_from as valid_from,
        dbt_valid_to as valid_to,
        
        case 
            when dbt_valid_to is null then true 
            else false 
        end as is_current_record

    from snapshot_parts
)

select * from final