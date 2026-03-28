{{ config(materialized="table", pre_hook="alter session set query_tag='dbt_demo'" )}}
select 
	N_NATIONKEY nation_id,
	N_NAME name,
	N_REGIONKEY region_id,
	N_COMMENT comment,
    current_timestamp() as cts
from {{ source('src','nations') }}

