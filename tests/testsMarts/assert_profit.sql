{{ config(
    severity = 'warn'
) }}

with sales as (
    select
        part_id,
        supplier_id,
        (net_item_sales_amount / quantity) as effective_unit_sales_price
    from {{ ref('fct_order') }} 
),

stock as (
    select
        part_id,
        supplier_id,
        unit_cost
    from {{ ref('fct_stock') }} 
),

margin_errors as (
    select
        s.part_id,
        s.effective_unit_sales_price,
        st.unit_cost
    from sales s
    inner join stock st
        on s.part_id = st.part_id 
        and s.supplier_id = st.supplier_id
    where s.effective_unit_sales_price < st.unit_cost
)

select * from margin_errors