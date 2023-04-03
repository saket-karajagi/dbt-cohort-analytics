{% snapshot user_snapshot %}

{{ config(target_database='fitbod', 
	      target_schema='snapshot',
          unique_key='user_id',
          strategy='check',
          check_cols=['email']
 )
}} 

select user_id, 
	   email 
from {{ source('fitbod', 'latest_users') }}

{% endsnapshot %}
