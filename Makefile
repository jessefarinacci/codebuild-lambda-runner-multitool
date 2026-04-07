.NOTPARALLEL:

ACC := $(shell aws sts get-caller-identity | jq --raw-output '.Account')
REG := $(ACC).dkr.ecr.us-east-1.amazonaws.com
REP := 00000000-0000-0000-0000-000000000000
TAG := codebuild-lambda-runner

all: build tag
	@true

build: test
	@echo ">> $(@)"
	@docker build --file Dockerfile --progress=plain --tag $(TAG) .

buildx: test
	@echo ">> $(@)"
	@docker buildx build --platform linux/amd64,linux/arm64 --tag $(TAG) .

login:
	@echo ">> $(@)"
	@aws ecr get-login-password | docker login --username AWS --password-stdin $(REG)/$(REP)

pushx: buildx
	@echo ">> $(@)"
	@docker buildx build --platform linux/amd64,linux/arm64 --push --tag $(REG)/$(REP):$(TAG) .

run:
	@echo ">> $(@)"
	@docker run --interactive --tty $(TAG) bash

tag:
	@echo ">> $(@)"
	@docker tag $(TAG) $(REG)/$(REP):$(TAG)

test:
	@echo ">> $(@)"
	@hadolint Dockerfile
