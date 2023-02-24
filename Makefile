.PHONY: go-models

go-models:
	@go-jsonschema \
		--package public \
		--resolve-extension json \
		--output pkg/schema/public/ekscluster_kfd_v1alpha2.go \
		schemas/public/ekscluster-kfd-v1alpha2.json
	@go-jsonschema \
		--package private \
		--resolve-extension json \
		--output pkg/schema/private/ekscluster_kfd_v1alpha2.go \
		schemas/private/ekscluster-kfd-v1alpha2.json
