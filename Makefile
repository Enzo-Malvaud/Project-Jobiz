# 1. CHARGEMENT DU .ENV
ifneq ("$(wildcard .env)","")
    include .env
    export $(shell sed 's/=.*//' .env)
endif

# 2. VARIABLES
DOCKER_COMPOSE = docker compose
PHP_CONT       = php-container
DB_CONT        = mysql-container
DB_NAME_FINAL  := $(if $(DB_NAME),$(DB_NAME),studi_jobiz)
DB_PASS_FINAL  := $(DB_PASSWORD)

# --- COMMANDES D'ENVIRONNEMENT ---

.PHONY: start-dev
start-dev: ## Démarre en mode DEV (avec phpMyAdmin)
	$(DOCKER_COMPOSE) --profile dev up -d

.PHONY: start-prod
start-prod: ## Démarre en mode PROD (sans outils de dev)
	$(DOCKER_COMPOSE) up -d

# --- TES COMMANDES EXISTANTES (CONSERVÉES) ---

stop: ## Arrête les conteneurs
	$(DOCKER_COMPOSE) down

build: ## Reconstruit les images
	$(DOCKER_COMPOSE) build --no-cache

php: ## Accès Terminal PHP
	docker exec -it $(PHP_CONT) sh

composer-install: ## Installation des dépendances
	docker exec -it $(PHP_CONT) composer install

db-import: ## Importe depuis backup.sql
	@echo "Importation dans $(DB_NAME_FINAL)..."
	docker exec -i $(DB_CONT) mysql -u root -p$(DB_PASS_FINAL) $(DB_NAME_FINAL) < backup.sql

clean: ## Nettoyage complet (Vire les volumes !)
	$(DOCKER_COMPOSE) down -v --remove-orphans