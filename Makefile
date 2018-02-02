IMAGE=johnpaulett/sham-oidc

build:
	docker build -t $(IMAGE) .

# docker push $(IMAGE):<tag>
