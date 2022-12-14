{{- if eq .spec.distribution.modules.logging.opensearch.type "single" -}}
{
  "index_patterns" : ["events-*"],
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0,
    "codec": "best_compression"
  }
}
{{- end }}
