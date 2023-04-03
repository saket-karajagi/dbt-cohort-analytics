## Project Files
- app
    - download_s3_object.py - The script that fetches input files from the S3 bucket
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
- Setup
- Get input data
- Build Docker containers
- Transform and load data to a Postgres DB using dbt
- Serve to a summary report

## Project Setup
### Download the prerequisites and setup the environment
- Download and install: Docker, Python3 and virtualenv
- Clone the repo and `cd` to this directory
- Open a terminal and create a Python virtual environment using:


    ```
    $ make build
    ```
### Fetch data from S3
- Connect to the S3 `cohort-analysis` bucket to get the data files:

    ```
    $ make run
    ```
### Build Docker containers
- Now that the CSV files are in the `data` folder, we can build the Docker containers using this command:


    ```
    docker-compose up --no--attach postgres
    ```
This command will build our `dbt` and `postgres` containers. This will also run our data loading and model transformations.

### Transform and load data to Postgres DB using dbt
During `docker-compose`, dbt runs the following commands
- `dbt debug`: Checks the connection with the Postgres database
- `dbt deps`: Installs the test dependencies
- `dbt seed`: Loads the CSV files into source tables in the database in `postgres`
- `dbt test`: Runs tests on the source tables in the database in `postgres`
- `dbt snapshot`: Creates snapshot tables for the source data
- `dbt run`: Runs the transformations and loads the data into the database


### Summary
- Summarize the counts for each cohort to a CSV file:

    ```
    $ make summary
    ```