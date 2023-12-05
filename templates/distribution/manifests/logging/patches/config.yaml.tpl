# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

auth_enabled: false
chunk_store_config:
  max_look_back_period: 0s
common:
  compactor_address: http://loki-distributed-compactor:3100
compactor:
  shared_store: filesystem
distributor:
  ring:
    kvstore:
      store: memberlist
frontend:
  compress_responses: true
  log_queries_longer_than: 5s
  tail_proxy_url: http://loki-distributed-querier:3100
frontend_worker:
  frontend_address: loki-distributed-query-frontend-headless:9095
ingester:
  chunk_block_size: 262144
  chunk_encoding: snappy
  chunk_idle_period: 30m
  chunk_retain_period: 1m
  lifecycler:
    ring:
      kvstore:
        store: memberlist
      replication_factor: 1
  max_transfer_retries: 0
  wal:
    dir: /var/loki/wal
ingester_client:
  grpc_client_config:
    grpc_compression: gzip
limits_config:
  enforce_metric_name: false
  max_cache_freshness_per_query: 10m
  reject_old_samples: true
  reject_old_samples_max_age: 168h
  split_queries_by_interval: 15m
memberlist:
  join_members:
    - loki-distributed-memberlist
query_range:
  align_queries_with_step: true
  cache_results: true
  max_retries: 5
  results_cache:
    cache:
      embedded_cache:
        enabled: true
        ttl: 24h
ruler:
  alertmanager_url: https://alertmanager.xx
  external_url: https://alertmanager.xx
  ring:
    kvstore:
      store: memberlist
  rule_path: /tmp/loki/scratch
  storage:
    local:
      directory: /etc/loki/rules
    type: local
runtime_config:
  file: /var/loki-distributed-runtime/runtime.yaml
schema_config:
  configs:
    - from: "2020-10-24"
      index:
        period: 24h
        prefix: index_
      object_store: s3
      schema: v11
      store: boltdb-shipper
server:
  http_listen_port: 3100
storage_config:
  aws:
{{- if eq .spec.distribution.modules.logging.loki.backend "minio" }}
    s3: http://{{ .spec.distribution.modules.logging.minio.rootUser.username }}:{{ .spec.distribution.modules.logging.minio.rootUser.password }}@minio-logging.logging.svc.cluster.local:9000/loki
    s3forcepathstyle: true
{{- end }}
{{- if eq .spec.distribution.modules.logging.loki.backend "externalEndpoint" }}
    s3: {{ ternary "http" "https" .spec.distribution.modules.logging.loki.externalEndpoint.insecure }}://{{ .spec.distribution.modules.logging.loki.externalEndpoint.accessKeyId }}:{{ .spec.distribution.modules.logging.loki.externalEndpoint.secretAccessKey }}@{{ .spec.distribution.modules.logging.loki.externalEndpoint.endpoint }}/{{ .spec.distribution.modules.logging.loki.externalEndpoint.bucketName }}
    s3forcepathstyle: true
{{- end }}
  boltdb_shipper:
    active_index_directory: /var/loki/index
    cache_location: /var/loki/cache
    cache_ttl: 24h
    resync_interval: 5s
    shared_store: s3
  filesystem:
    directory: /var/loki/chunks
table_manager:
  retention_deletes_enabled: false
  retention_period: 0s
