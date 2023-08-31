IMAGE=johnpaulett/sham-oidc
VERSION=$(shell date +%Y%m%d)
TAG=$(IMAGE):$(VERSION)

build:
	docker build -t $(TAG) -t $(IMAGE) .

# Requires docker buildx create --use
buildx:
	docker buildx build --platform=linux/amd64,linux/arm64 -t $(TAG) -t $(IMAGE) --push .

# Not needed for buildx
push:
	docker push $(TAG)
