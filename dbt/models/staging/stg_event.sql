with source as (
    select *
    from {{ ref('event_snapshot') }}
),

events as (
    select  user_id,
			feature_key,
        	feature_value,
        	updated_at
    from source
    where dbt_valid_to is null
)

select
    *
from events
