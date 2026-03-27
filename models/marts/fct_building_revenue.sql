with orders as 
( select order_id, customer_id, order_date, ship_priority from {{ ref('stg_orders')}}),
line as 
( select order_id, extended_price, discount_percentage from {{ ref('stg_line_items')}}),
customer as 
( select customer_id from {{ ref('stg_customers')}}  where market_segment = 'BUILDING' )

SELECT
    orders.order_id,
    orders.order_date,
    orders.ship_priority,
    SUM(line.extended_price * (1 - line.discount_percentage)) AS revenue,
FROM
    orders
    INNER JOIN customer ON customer.customer_id = orders.customer_id
    INNER JOIN line ON orders.order_id = line.order_id
GROUP BY
    1,2,3
ORDER BY
    4 DESC, 2
LIMIT 10