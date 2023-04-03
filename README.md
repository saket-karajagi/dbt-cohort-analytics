## Project Files
- app
    - download_s3_object.py - The script that fetches input files from a S3 bucket
    - summarize_cohorts.py - The script to generate the summary report to a CSV file
    - config.py - To store S3 credentials
- dbt
    - models - Contains the sql scripts and schema.yml files for creating transformations
    - dbt_entrypoint.sh - Script that will serve as the entrypoint when running the `dbt` container
    - Dockerfile - Contains the commands to create the custom Docker image
    - dbt_project.yml - File to configure dbt
    - packages.yml - File for test dependencies
    - profiles.yml - File to configure connection of `dbt` to `postgres`
- docker-compose.yml - YAML file to orchestrate Docker containers

## Workflow
Let's break this down into major steps
- Setup the environment
- Get input data
- Build Docker containers
- Transform and load data to a Postgres DB using dbt
- Serve to a summary report

## Project Setup
### Download the prerequisites and setup the environment
- Prerequisites: Docker Desktop, Python3 and virtualenv
- Open a terminal, clone the repo and `cd` to this directory
- Add the supplied file app/config.py
- Create a Python virtual environment using:


    ```
    $ make build
    ```
### Fetch data from S3
- Connect to the S3 `cohort-analysis` bucket and download the input data files:

    ```
    $ make run
    ```
### Build Docker containers
- Start Docker Desktop
- Now that the CSV files are in the `data` folder, we can build the Docker containers using this command:


    ```
    docker-compose up --no-attach postgres
    ```
This command will build the `dbt` and `postgres` containers. This will also load the data and run the transformations on dbt.

### Load and transform data on Postgres DB using dbt
During `docker-compose`, dbt runs the following commands
- `dbt debug`: Check connection with the Postgres database
- `dbt deps`: Install the test dependencies
- `dbt seed`: Load the CSV files into source tables in `postgres`
- `dbt test`: Run tests on the source data in `postgres`
- `dbt snapshot`: Create snapshot tables for the source data
- `dbt run`: Run the transformations to create fact tables on the database


### Summary
- Summarize the user counts for each cohort to a CSV file:

    ```
    $ make summary
    ```
