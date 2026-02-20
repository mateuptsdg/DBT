{% test is_positive(model, column_name) %}

with validation as (
    select
        {{ column_name }} as field_to_test
    from {{ model }}
)

select *
from validation
where field_to_test <= 0

{% endtest %}