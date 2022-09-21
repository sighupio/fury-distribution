.PHONY: go-models

go-models:
	@go-jsonschema -p schemas schemas/ekscluster-kfd-v1alpha2.json -o pkg/schemas/ekscluster_kfd_v1alpha2.go
