FROM python:3.8.6

# Update and install system packages
RUN apt-get update -y && \
  apt-get install --no-install-recommends -y -q \
  git libpq-dev python-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install DBT
RUN pip3 install --force-reinstall MarkupSafe==2.0.1
RUN pip install dbt-core==1.4.0
RUN pip install dbt-postgres==1.4.0

# Set environment variables
ENV DBT_DIR /dbt

# Set working directory
WORKDIR $DBT_DIR

CMD ["/bin/bash"]
