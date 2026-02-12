{% test is_positive(model, column_name) %}

with validation as (
    select
        {{ column_name }} as field_to_test
    from {{ model }}
)

select *
from validation
-- El test falla si encuentra filas donde el valor sea menor o igual a 0
where field_to_test <= 0

{% endtest %}