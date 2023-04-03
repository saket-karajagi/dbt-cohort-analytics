#!/bin/bash
cp -r /data/. /dbt/data &&
dbt debug --profiles-dir . &&
dbt deps --profiles-dir . &&
dbt seed --profiles-dir . &&
dbt test --profiles-dir . &&
dbt snapshot --profiles-dir . &&
dbt run --profiles-dir . &&
dbt clean
