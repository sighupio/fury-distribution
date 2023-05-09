.PHONY: license-add license-check

license-add:
	@addlicense \
	-c "SIGHUP s.r.l" \
	-v -l bsd -y "2017-present" \
	-ignore 'templates/distribution/**' \
	-ignore 'target/**' \
	-ignore 'vendor/**' \
	.

license-check:
	@addlicense \
	-c "SIGHUP s.r.l" \
	-v -l bsd -y "2017-present" \
	-ignore 'templates/distribution/**' \
	-ignore 'target/**' \
	-ignore 'vendor/**' \
	--check .

.PHONY: lint-go

lint-go:
	@golangci-lint -v run --color=always --config=.rules/.golangci.yml --modules-download-mode=mod ./...

.PHONY: tools-go

tools-go:
	@go install github.com/evanphx/json-patch/cmd/json-patch@v5.6.0

.PHONY: generate-private-schema dump-go-models

generate-go-models: dump-private-schema
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

dump-private-schema:
	@cat schemas/public/ekscluster-kfd-v1alpha2.json | \
	json-patch -p schemas/private/patch.json | \
	jq -r > schemas/private/ekscluster-kfd-v1alpha2.json
