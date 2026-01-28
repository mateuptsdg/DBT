with payments as (
select * from {{ref('stg_stripe__payments')}}
where status='success'),
pivoted as (select order_id, sum(case when payment_method = 'bank_transfer' then amount else 0 end) as bank_transfer_amount 
from payments group by 1) 
select * from pivoted