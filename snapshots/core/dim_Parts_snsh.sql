with snapshot_parts as (
    select * from {{ ref('snsh_part') }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['part_id', 'dbt_valid_from']) }} as part_key,
        part_id,
        part_name,
        {{ remove_prefix('manufacturer_name') }} as manufacturer_num,
        {{ remove_prefix('brand_name') }} as brand_num,
        part_type,
        part_size,
        container_type,
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

        