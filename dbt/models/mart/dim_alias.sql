SELECT user_id,
       alias_user_id
FROM {{ ref('stg_alias') }}
