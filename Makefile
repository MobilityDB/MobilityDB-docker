# When processing the rules for tagging and pushing container images with the
# "latest" tag, the following variable will be the version that is considered
# to be the latest.
LATEST_VERSION=17-3.5-1.2

# The following logic evaluates the VERSION variable that may have been previously specified.
# The VERSIONS variable is set to contain the version(s) to be processed.
ifdef VERSION
    VERSIONS=$(VERSION) # If a version was specified, VERSIONS only contains the specified version
else # If no version was specified, VERSIONS should contain all versions
    VERSIONS = $(foreach df,$(wildcard */Dockerfile),$(df:%/Dockerfile=%))
endif

BUILD_LATEST_DEP=build-$(LATEST_VERSION)
PUSH_LATEST_DEP=push-$(LATEST_VERSION)
PUSH_DEP=push-latest $(PUSH_LATEST_DEP)
# The "latest" tag shouldn't be processed if a VERSION was explicitly
# specified but does not correspond to the latest version.
ifdef VERSION
    ifneq ($(VERSION),$(LATEST_VERSION))
        PUSH_LATEST_DEP=
        BUILD_LATEST_DEP=
        PUSH_DEP=
    endif
endif

# The repository and image names default to the official but can be overriden
# via environment variables.
REPO_NAME  ?= mobilitydb
IMAGE_NAME ?= mobilitydb

DOCKER=docker
DOCKERHUB_DESC_IMG=peterevans/dockerhub-description:latest

build: $(foreach version,$(VERSIONS),build-$(version))

### RULES FOR BUILDING ###

define build-version
build-$1:
	$(DOCKER) build --pull -t $(REPO_NAME)/$(IMAGE_NAME):$(shell echo $1) $1
	$(DOCKER) images          $(REPO_NAME)/$(IMAGE_NAME):$(shell echo $1)
endef
$(foreach version,$(VERSIONS),$(eval $(call build-version,$(version))))


### RULES FOR TAGGING ###

tag-latest: $(BUILD_LATEST_DEP)
	$(DOCKER) image tag $(REPO_NAME)/$(IMAGE_NAME):$(LATEST_VERSION) $(REPO_NAME)/$(IMAGE_NAME):latest


### RULES FOR PUSHING ###

push: $(foreach version,$(VERSIONS),push-$(version)) $(PUSH_DEP)

define push-version
push-$1:
	$(DOCKER) image push $(REPO_NAME)/$(IMAGE_NAME):$(version)
endef
$(foreach version,$(VERSIONS),$(eval $(call push-version,$(version))))

push-latest: tag-latest $(PUSH_LATEST_DEP)
	$(DOCKER) image push $(REPO_NAME)/$(IMAGE_NAME):latest

# Update the Docker Hub repository description using the README.md file
update-dockerhub-description:
	@$(DOCKER) run --rm -v "$(PWD)":/workspace \
               -e DOCKERHUB_USERNAME='$(DOCKERHUB_USERNAME)' \
               -e DOCKERHUB_PASSWORD='$(DOCKERHUB_PASSWORD)' \
               -e DOCKERHUB_REPOSITORY='$(REPO_NAME)/$(IMAGE_NAME)' \
               -e README_FILEPATH='/workspace/README.md' \
               $(DOCKERHUB_DESC_IMG)

.PHONY: build tag-latest push push-latest update-dockerhub-description \
        $(foreach version,$(VERSIONS),build-$(version)) \
        $(foreach version,$(VERSIONS),push-$(version))
