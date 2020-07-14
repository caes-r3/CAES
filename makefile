APP_NAME=r3hello

all: venv build save
	echo ok

clean:
	-docker ps -a | grep $(APP_NAME) && echo "dev isn't clean"
	echo "Please clean up manuallly:"
	echo "  docker rm r3hello"

build:
	docker build -t $(APP_NAME) .
	docker image ls $(APP_NAME)
venv:
	if [ -d .py ] ; \
	then \
		echo "virtualenv already built, skipping..."; \
	else \
		python3 -m venv .py; \
		.py/bin/python3 -m pip install -r requirements.txt; \
	fi

export:
	mkdir -p BUILD
	#docker save $(APP_NAME) > BUILD/$(APP_NAME).tar
	docker run -d --name $(APP_NAME) $(APP_NAME)
	docker export $(APP_NAME) > BUILD/$(APP_NAME).tar
	ls -lh BUILD/

export_test:
	
save:
	mkdir -p BUILD
	docker save $(APP_NAME) > BUILD/$(APP_NAME).tar
	ls -lh BUILD/
test:
	docker image ls $(APP_NAME)_imported_image
	docker image rm $(APP_NAME)_imported_image 2>/dev/null || echo removed old image
	cat BUILD/$(APP_NAME).tar | docker import - $(APP_NAME)_imported_image
	docker run -d --name $(APP_NAME)_imported_app $(APP_NAME)_imported_image


tmp-release:
	scp BUILD/r3hello.tar user@10.60.6.242:/home/user/R3_TEMP_BUILD/
run:
	docker run --name $(APP_NAME) $(APP_NAME)

myapp_run: venv
	.py/bin/python3 myapp.py
