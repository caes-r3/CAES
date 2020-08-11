
all: venv test
	
venv:

	@if [ -d .py ] ; \
	then \
		echo "virtualenv already built, skipping..."; \
	else \
		python3 -m venv .py; \
		.py/bin/python3 -m pip install -r requirements.txt; \
	fi

test:
	python health_check_server.py
