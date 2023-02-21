.PHONY: go-models

go-models:
	@go-jsonschema -p external --resolve-extension json schemas/ekscluster-kfd-v1alpha2-external.json -o pkg/schema/external/ekscluster_kfd_v1alpha2.go
	@go-jsonschema -p internal --resolve-extension json schemas/ekscluster-kfd-v1alpha2-internal.json -o pkg/schema/internal/ekscluster_kfd_v1alpha2.go

test-external-schemas:
	@TESTS=$$(ls schemas/tests/external/ekscluster-kfd-v1alpha2/*.yaml | sort); \
	echo "$${TESTS}" | xargs -n1 -I{} sh -c "yq {} -o json > {}.json;"; \
	echo "$${TESTS}" | xargs -n1 -I{} sh -c "echo; echo 'Validating {}...'; echo; jv schemas/ekscluster-kfd-v1alpha2-external.json {}.json || true;"; \
	echo "$${TESTS}" | xargs -n1 -I{} sh -c "rm {}.json;"
