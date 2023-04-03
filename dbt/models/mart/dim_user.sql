SELECT user_id,
       email
FROM {{ ref('stg_user') }}
