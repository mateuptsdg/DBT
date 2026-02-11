{{ config(materialized='table') }}

with date_dimension as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('1990-01-01' as date)",
        end_date="cast('2030-01-01' as date)"
    ) }}
)

select
    {{ to_date_key('date_day') }} as date_key,
    date_day as full_date,
    day(date_day) as day_of_month,
    month(date_day) as month_number,
    year(date_day) as year_number,
    
from date_dimension