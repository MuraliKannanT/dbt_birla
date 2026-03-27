select
    o_orderkey,
    o_custkey,
    o_orderdate,
    o_orderstatus,
    o_totalprice
from {{ ref('stg_orders') }}