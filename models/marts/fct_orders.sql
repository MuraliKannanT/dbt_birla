select
    order_id,
    customer_id,
    order_date,
    status_code,
    total_price
from {{ ref('stg_orders') }}