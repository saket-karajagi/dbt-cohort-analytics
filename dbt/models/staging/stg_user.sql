with source as (
    select 
        *
    from {{ ref('user_snapshot') }}
),

users as (
    select  user_id,
			email
    from source
    where dbt_valid_to is null
)

select 
    *
from users
