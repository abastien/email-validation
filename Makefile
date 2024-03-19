export USER_ID := $(shell id -u)
export USER_NAME := $(shell whoami)
export GROUP_ID := $(shell id -g)
export GROUP_NAME := $(shell id -g -n | whoami)
export GIT_USER_NAME := $(shell git config user.name)
export GIT_USER_EMAIL := $(shell git config user.email)

.PHONY: build shell

build :
	@docker-compose build \
		--build-arg USER_ID=$(USER_ID) \
		--build-arg USER_NAME=$(USER_NAME) \
		--build-arg GROUP_ID=$(GROUP_ID) \
		--build-arg GROUP_NAME=$(GROUP_NAME) \
		--build-arg GIT_USER_NAME=$(GIT_USER_NAME) \
		--build-arg GIT_USER_EMAIL=$(GIT_USER_EMAIL)

shell : build
	@docker-compose run -it --rm --user $(USER_ID):$(GROUP_ID) email-validation-cli bash
