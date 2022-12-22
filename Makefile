.PHONY: go-models

go-models:
	@go-jsonschema -p schema --resolve-extension json schemas/ekscluster-kfd-v1alpha2.json -o pkg/schema/ekscluster_kfd_v1alpha2.go

test-schemas:
	@find schemas/tests/ekscluster-kfd-v1alpha2 -name "*.yaml" \
		-exec echo \; \
		-exec echo 'Validating {}...' \; \
		-exec echo \; \
		-exec sh -c "yq {} -o json > {}.json" \; \
		-exec sh -c "jv schemas/ekscluster-kfd-v1alpha2.json {}.json || true" \; \
		-exec rm {}.json \;
	@echo
