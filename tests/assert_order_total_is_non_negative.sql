select
    order_id,
    order_total
from {{ ref('orders') }}
where order_total < 0
