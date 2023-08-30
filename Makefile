IMAGE=johnpaulett/sham-oidc

build:
	docker build -t $(IMAGE) .

# Requires docker buildx create --use
buildx:
	docker buildx build --platform=linux/amd64,linux/arm64 -t $(IMAGE) --push .

# TODO Tag with :YYYYMMDD
push:
	docker push $(IMAGE)
