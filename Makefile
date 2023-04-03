build: requirements.txt
	@echo "--CREATING virtual enviroment venv--";
	@python3 -m venv venv;
	@echo "--INSTALLING dependencies--";
	@. venv/bin/activate; pip install --upgrade pip && pip install -r requirements.txt;

run:
	@echo "--GETTING data from S3--";
	@. venv/bin/activate; python3 app/download_s3_object.py;
	@echo "--COMPLETE--";

summary:
	@echo "--COPYING data to CSV--";
	@. venv/bin/activate; python3 app/summarize_cohorts.py;
	@echo "--COMPLETED TO data/output.csv--";

clean:
	@echo "--DELETING venv and pycache--";
	@rm -r venv; find . | grep -E "(.cache|debug.log|.csv)" | xargs rm -rf;
	@find . | grep -E "(__pycache__|.pytest_cache)" | xargs rm -rf;
