NAME = inception 
DOCKER_COMPOSE= docker compose -f srcs/docker-compose.yml
DOCKER = docker
ENV = ./srcs/.env
DATA_MARIADB = ~/data/mariadb
DATA_WORDPRESS = ~/data/wordpress


all: $(NAME)

$(NAME): $(ENV) $(DATA_MARIADB) $(DATA_WORDPRESS)
	$(DOCKER_COMPOSE) up -d

$(ENV):
	@if [ ! -f ./srcs/.env ]; then \
		cp ~/.env ./srcs/; \
	fi

$(DATA_MARIADB):
	mkdir -p $(DATA_MARIADB)
$(DATA_WORDPRESS):
	mkdir -p $(DATA_WORDPRESS)

build: $(ENV)
	$(DOCKER_COMPOSE) build

stop: $(ENV)
	$(DOCKER_COMPOSE) stop

start: $(ENV)
	$(DOCKER_COMPOSE) start

restart: stop start

clean: stop

fclean: clean
	@echo "Stopping and removing all containers..."
	$(DOCKER_COMPOSE) down --remove-orphans --volumes --rmi all || true
	$(DOCKER) system prune -a --volumes -f || true
	@echo "Removing data directories..."
	sudo rm -rf $(DATA_WORDPRESS) $(DATA_MARIADB)
	rm -f srcs/$(ENV)

rmdata: $(DATA_MARIADB) $(DATA_WORDPRESS)
	sudo rm -rf $(DATA_WORDPRESS) $(DATA_MARIADB)

re2: $(ENV) stop rmdata
	$(DOCKER) rm -f nginx wordpress mariadb
	$(DOCKER) volume rm -f srcs_mariadb
	$(DOCKER) volume rm -f srcs_wordpress
	mkdir -p $(DATA_WORDPRESS)
	mkdir -p $(DATA_MARIADB)
	@echo "Removing data directories..."
	$(DOCKER_COMPOSE) build
	$(DOCKER_COMPOSE) up -d

check:
	@$(DOCKER) ps -a
	@echo ""
	@$(DOCKER) volume ls
	@echo ""
	@$(DOCKER) images
	@echo ""
	@$(DOCKER) network ls

log: $(ENV)
	$(DOCKER_COMPOSE) logs -f

getUser: $(ENV)


re: fclean all
