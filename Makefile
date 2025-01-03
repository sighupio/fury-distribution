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

.PHONY: format-go fmt fumpt imports gci formattag

format-go: fmt fumpt imports gci formattag

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

formattag:
	@find . -name "*.go" -type f -not -path '*/vendor/*' \
	| sed 's/^\.\///g' \
	| xargs -I {} sh -c 'formattag -file {}'

.PHONY: lint-go
lint-go:
	@golangci-lint -v run --color=always --config=.rules/.golangci.yml ./...

.PHONY: tools-go
tools-go:
	@go install github.com/evanphx/json-patch/v5/cmd/json-patch@v5.9.0
	@go install github.com/google/addlicense@v1.1.1
	@go install mvdan.cc/gofumpt@v0.7.0
	@go install golang.org/x/tools/cmd/goimports@v0.26.0
	@go install github.com/daixiang0/gci@v0.10.1
	@go install github.com/momaek/formattag@v0.0.9
	@go install github.com/santhosh-tekuri/jsonschema/cmd/jv@v0.4.0
	@go install github.com/sighupio/go-jsonschema@latest
	@go install github.com/sighupio/md-gen@latest

.PHONY: _generate-go-models
_generate-go-models: dump-private-schema
	@go-jsonschema \
		--package public \
		--resolve-extension json \
		--output pkg/apis/ekscluster/v1alpha2/public/schema.go \
		schemas/public/ekscluster-kfd-v1alpha2.json
	@go-jsonschema \
		--package private \
		--resolve-extension json \
		--output pkg/apis/ekscluster/v1alpha2/private/schema.go \
		schemas/private/ekscluster-kfd-v1alpha2.json
	@go-jsonschema \
		--package public \
		--resolve-extension json \
		--output pkg/apis/kfddistribution/v1alpha2/public/schema.go \
		schemas/public/kfddistribution-kfd-v1alpha2.json
	@go-jsonschema \
		--package public \
		--resolve-extension json \
		--output pkg/apis/onpremises/v1alpha2/public/schema.go \
		schemas/public/onpremises-kfd-v1alpha2.json

.PHONY: generate-go-models
generate-go-models: _generate-go-models format-go

.PHONY: generate-docs
generate-docs:
	@md-gen gen --input schemas/public/onpremises-kfd-v1alpha2.json --output docs/schemas/onpremises-kfd-v1alpha2.md --overwrite --banner banners/onpremises.md
	@md-gen gen --input schemas/public/kfddistribution-kfd-v1alpha2.json --output docs/schemas/kfddistribution-kfd-v1alpha2.md --overwrite --banner banners/kfddistribution.md
	@md-gen gen --input schemas/public/ekscluster-kfd-v1alpha2.json --output docs/schemas/ekscluster-kfd-v1alpha2.md --overwrite --banner banners/ekscluster.md

.PHONY: generate-np-diagrams
generate-np-diagrams:
	docker run --rm -v $(PWD)/docs/network-policies:/workdir minlag/mermaid-cli:latest -i "/workdir/overview.md" -o "/workdir/overview.png" -w 2048 -H 1536 -b white
	docker run --rm -v $(PWD)/docs/network-policies/modules/auth:/workdir minlag/mermaid-cli:latest -i "/workdir/sso.md" -o "/workdir/sso.png" -w 2048 -H 1536 -b white
	docker run --rm -v $(PWD)/docs/network-policies/modules/ingress:/workdir minlag/mermaid-cli:latest -i "/workdir/single.md" -o "/workdir/single.png" -w 2048 -H 1536 -b white
	docker run --rm -v $(PWD)/docs/network-policies/modules/ingress:/workdir minlag/mermaid-cli:latest -i "/workdir/dual.md" -o "/workdir/dual.png" -w 2048 -H 1536 -b white
	docker run --rm -v $(PWD)/docs/network-policies/modules/logging:/workdir minlag/mermaid-cli:latest -i "/workdir/loki.md" -o "/workdir/loki.png" -w 2048 -H 1536 -b white
	docker run --rm -v $(PWD)/docs/network-policies/modules/logging:/workdir minlag/mermaid-cli:latest -i "/workdir/opensearch.md" -o "/workdir/opensearch.png" -w 2048 -H 1536 -b white
	docker run --rm -v $(PWD)/docs/network-policies/modules/monitoring:/workdir minlag/mermaid-cli:latest -i "/workdir/mimir.md" -o "/workdir/mimir.png" -w 2048 -H 1536 -b white
	docker run --rm -v $(PWD)/docs/network-policies/modules/monitoring:/workdir minlag/mermaid-cli:latest -i "/workdir/prometheus.md" -o "/workdir/prometheus.png" -w 2048 -H 1536 -b white
	docker run --rm -v $(PWD)/docs/network-policies/modules/opa:/workdir minlag/mermaid-cli:latest -i "/workdir/gatekeeper.md" -o "/workdir/gatekeeper.png" -w 2048 -H 1536 -b white
	docker run --rm -v $(PWD)/docs/network-policies/modules/opa:/workdir minlag/mermaid-cli:latest -i "/workdir/kyverno.md" -o "/workdir/kyverno.png" -w 2048 -H 1536 -b white
	docker run --rm -v $(PWD)/docs/network-policies/modules/tracing:/workdir minlag/mermaid-cli:latest -i "/workdir/tempo.md" -o "/workdir/tempo.png" -w 2048 -H 1536 -b white

.PHONY: dump-private-schema
dump-private-schema:
	@cat schemas/public/ekscluster-kfd-v1alpha2.json | \
	json-patch -p schemas/private/ekscluster-kfd-v1alpha2.patch.json | \
	jq -r > schemas/private/ekscluster-kfd-v1alpha2.json
