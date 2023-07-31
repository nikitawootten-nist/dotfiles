SHELL:=/usr/bin/env bash

# This help command was adapted from https://github.com/tiiuae/sbomnix
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?##.*$$' $(MAKEFILE_LIST) | awk 'BEGIN { \
	  FS = ":.*?## "; \
	  printf "\033[1m%-30s\033[0m %s\n", "TARGET", "DESCRIPTION" \
	} \
	{ printf "\033[32m%-30s\033[0m %s\n", $$1, $$2 }'

.PHONY: switch-home
switch-home: ## Switch local home-manager config
	home-manager switch --flake .

.PHONY: build-home
build-home: ## Build local home-manager config
	home-manager build --flake .

.PHONY: test
test: ## Test flake outputs
	nix flake check

.PHONY: update
update: ## Update inputs in "flake.lock"
	nix flake update