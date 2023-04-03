import sys, psycopg2
import boto3
from os.path import abspath

conn = psycopg2.connect("host=localhost dbname=fitbod user=dbt password=password1")
cur = conn.cursor()

sql = "COPY (SELECT * FROM cohort_analysis.fct_cohort_summary) TO STDOUT WITH CSV DELIMITER ',' HEADER"

with open("data/output.csv", "w") as file:
    cur.copy_expert(sql, file)
