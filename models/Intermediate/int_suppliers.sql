{{  config( materialized='incremental', unique_key='supplier_id' ) }}

with supplier as (
    select * from {{ ref('stg_suppliers') }} 

{% if is_incremental() %}
where updated_time > (select max(updated_time) from {{ this }} ) 
{% endif %} )

select * from supplier



