with source as (
    select 
        *
    from {{ ref('alias_snapshot') }}
),

aliases as (
    select  user_id,
			alias_user_id,
			updated_at
    from source
    where dbt_valid_to is null
)

select
    *
from aliases
