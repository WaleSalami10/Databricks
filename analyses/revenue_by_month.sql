select
    date_trunc('month', ordered_at) as order_month,
    sum(order_total) as total_revenue
from {{ ref('orders') }}
group by 1
order by 1
