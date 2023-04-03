WITH RECURSIVE compressed_aliases(user_id, alias_user_id, all_parents, lvl) as (

    SELECT u.user_id,
           a.alias_user_id,
           array[u.user_id] AS all_parents,
           0                AS lvl
    FROM {{ ref('dim_user') }} u
    JOIN {{ ref('dim_alias') }} a ON u.user_id = a.user_id

    UNION ALL

    SELECT ca.user_id,
           a.alias_user_id,
           ca.all_parents || a.user_id AS all_parents,
           lvl + 1                     AS lvl
    FROM compressed_aliases ca
    JOIN {{ ref('dim_alias') }} a ON ca.alias_user_id = a.user_id 
) 

CYCLE alias_user_id SET is_cycle USING cycle_path

SELECT user_id, 
       alias_user_id, 
       all_parents, 
       lvl, 
       is_cycle
FROM compressed_aliases
ORDER BY user_id, lvl
