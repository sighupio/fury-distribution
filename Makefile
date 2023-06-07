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

.PHONY: format-go fmt fumpt imports gci

format-go: fmt fumpt imports gci

fmt:
	@find . -name "*.go" -type f -not -path '*/vendor/*' \
	| sed 's/^\.\///g' \
	| xargs -I {} sh -c 'echo "formatting {}.." && gofmt -w -s {}'

fumpt:
	@find . -name "*.go" -type f -not -path '*/vendor/*' \
	| sed 's/^\.\///g' \
	| xargs -I {} sh -c 'echo "formatting {}.." && gofumpt -w -extra {}'

imports:
	@goimports -v -w -e -local github.com/sighupio pkg/

gci:
	@find . -name "*.go" -type f -not -path '*/vendor/*' \
	| sed 's/^\.\///g' \
	| xargs -I {} sh -c 'echo "formatting imports for {}.." && \
	gci write --skip-generated  -s standard -s default -s "Prefix(github.com/sighupio)" {}'

.PHONY: lint-go

lint-go:
	@golangci-lint -v run --color=always --config=.rules/.golangci.yml ./...

.PHONY: tools-go

tools-go:
	@go install github.com/evanphx/json-patch/cmd/json-patch@v5.6.0
	@go install github.com/google/addlicense@v1.1.1
	@go install mvdan.cc/gofumpt@v0.5.0
	@go install golang.org/x/tools/cmd/goimports@v0.9.3
	@go install github.com/daixiang0/gci@v0.10.1

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
