import boto3
from os.path import abspath
import config

s3 = boto3.client('s3', 
	aws_access_key_id=config.AWS_KEY_ID,
	aws_secret_access_key=config.AWS_SECRET_ACCESS_KEY,
	)

s3.download_file('cohort-analysis', 'input/users.csv', abspath('data/latest_users.csv'))
s3.download_file('cohort-analysis', 'input/alias.csv', abspath('data/latest_aliases.csv'))
s3.download_file('cohort-analysis', 'input/events.csv', abspath('data/latest_events.csv'))
