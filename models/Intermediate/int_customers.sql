with cust as 
(select customer_id, name as customer_name, address, phone, nation_id c_nation_id from {{ ref('stg_customers') }} ),
nation as
(select nation_id, name as nation_name, region_id n_region_id from {{ ref ('stg_nations') }} ),
region as 
(select region_id, name as region_name from {{ ref('stg_regions') }} )

select * exclude (nation_id, region_id, c_nation_id, n_region_id) from cust 
join nation on cust.c_nation_id = nation.nation_id
join region on nation.n_region_id = region.region_id

