SELECT 	user_id,
		feature_key,
		feature_value
FROM {{ ref('stg_event') }}
