.PHONY: help
help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-18s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

#
# If you want to see the full commands, run:
#   NOISY_BUILD=y make
#
ifeq ($(NOISY_BUILD),)
    ECHO_PREFIX=@
    CMD_PREFIX=@
else
    ECHO_PREFIX=@\#
    CMD_PREFIX=
endif

TAG=$(shell git rev-parse HEAD)

##@ Artifacts - Command to build and publish artifacts
inviter-image: Dockerfile ## Build continaer image for the InstructLab UI Inviter
	$(ECHO_PREFIX) printf "  %-12s Dockerfile\n" "[docker]"
	$(CMD_PREFIX) docker build -f Dockerfile --platform linux/amd64 -t quay.io/instructlab-ui/inviter:$(TAG) .
	$(CMD_PREFIX) docker tag quay.io/instructlab-ui/inviter:$(TAG) quay.io/instructlab-ui/inviter:main
