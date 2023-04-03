SELECT  COUNT(DISTINCT user_id) AS user_count,
		feature_key,
		feature_value AS feature_variation
FROM {{ ref('fct_cohort') }}
GROUP BY feature_key, feature_value
