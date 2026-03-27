select 
	R_REGIONKEY region_id,
	R_NAME region_name,
	R_COMMENT comment
from {{ source('src','regions') }}

