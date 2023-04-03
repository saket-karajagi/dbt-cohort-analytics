SELECT  e.feature_key,
		e.feature_value,
		u.user_id,
		u.email
FROM {{ ref('dim_event') }} e
JOIN {{ ref('dim_user') }} u ON e.user_id = u.user_id
       
UNION ALL
      
SELECT  e.feature_key,
		e.feature_value,
		u.user_id,
		u.email
FROM {{ ref('dim_event') }} e
JOIN {{ ref('dim_alias_compressed') }} a ON e.user_id = a.alias_user_id
JOIN {{ ref('dim_user') }} u ON a.user_id = u.user_id
