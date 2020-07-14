APP_NAME=r3hello

all: venv build save
	

clean:
	-sudo docker ps -a | grep $(APP_NAME) && echo "dev isn't clean"
	-echo "clean up in 3 seconds, ctrl-c to abort"
	-sleep 3 && sudo docker rm r3hello

build:
	sudo docker build -t $(APP_NAME) .
	sudo docker image ls $(APP_NAME)
venv:
	@if [ -d .py ] ; \
	then \
		echo "virtualenv already built, skipping..."; \
	else \
		python3 -m venv .py; \
		.py/bin/python3 -m pip install -r requirements.txt; \
	fi

export:
	mkdir -p BUILD
	sudo docker run -d --name $(APP_NAME) $(APP_NAME)
	sudo docker export $(APP_NAME) > BUILD/$(APP_NAME).tar
	ls -lh BUILD/

export_test:
	
save:
	mkdir -p BUILD
	sudo docker save $(APP_NAME) > BUILD/$(APP_NAME).tar
	ls -lh BUILD/
test:
	sudo docker image ls $(APP_NAME)_imported_image
	sudo docker image rm $(APP_NAME)_imported_image 2>/dev/null || echo removed old image
	cat BUILD/$(APP_NAME).tar | sudo docker import - $(APP_NAME)_imported_image
	sudo docker run -d --name $(APP_NAME)_imported_app $(APP_NAME)_imported_image


tmp-release:
	scp BUILD/r3hello.tar user@10.60.6.242:/home/user/R3_TEMP_BUILD/
run:
	sudo docker run --name $(APP_NAME) $(APP_NAME)

myapp_run: venv
	.py/bin/python3 myapp.py
