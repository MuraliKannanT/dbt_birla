select
	C_CUSTKEY customer_id,
	C_NAME name,
	C_ADDRESS address,
	C_NATIONKEY nation_id,
	C_PHONE phone,
	C_ACCTBAL account_balance,
	C_MKTSEGMENT market_segment,
	C_COMMENT comment
from {{ source('src','customers') }}
