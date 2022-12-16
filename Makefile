.PHONY: go-models

go-models:
	@go-jsonschema -p schema schemas/ekscluster-kfd-v1alpha2.json -o pkg/schema/ekscluster_kfd_v1alpha2.go
