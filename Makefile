.PHONY: run start stop

PROJ_NAME = cms-utilization-db
CONTAINER_DEV_IMAGE = "sudowing/$(PROJ_NAME):develop"

build:
	docker build -t $(CONTAINER_DEV_IMAGE) -f docker/Dockerfile .
	# docker build --pull -t $(CONTAINER_DEV_IMAGE) -f docker/Dockerfile .

release:
	make build
	docker tag $(CONTAINER_DEV_IMAGE) sudowing/$(PROJ_NAME):master
	# docker tag $(CONTAINER_DEV_IMAGE) sudowing/$(PROJ_NAME):1.1.0
	# docker tag $(CONTAINER_DEV_IMAGE) sudowing/$(PROJ_NAME):latest
	# docker tag $(CONTAINER_DEV_IMAGE) sudowing/$(PROJ_NAME):edge

publish:
	# docker push sudowing/$(PROJ_NAME):1.1.0
	docker push sudowing/$(PROJ_NAME):latest
	docker push sudowing/$(PROJ_NAME):edge

run:
	@docker-compose -f docker-compose.yml -f docker-compose.development.yml up

start:
	@docker-compose -f docker-compose.yml up -d

stop:
	@docker-compose stop

clean:
	@docker-compose down --remove-orphan

enter:
	docker exec -it cms-utilization-db_cms-utilization-postgres_1 bash

db-load-via-etl:
	docker exec -it cms-utilization-db_cms-utilization-postgres_1 bash /etl/scripts/etl.process.sh

db-load-via-sql:
	docker exec -it cms-utilization-db_cms-utilization-postgres_1 bash /etl/scripts/schema.load.sh

db-dump-sql:
	docker exec -it cms-utilization-db_cms-utilization-postgres_1 bash /etl/scripts/schema.dump.sh
