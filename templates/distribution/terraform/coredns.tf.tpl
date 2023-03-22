locals {
  coredns_scheduling_patch = {
    spec = {
      template = {
        spec = {
          nodeSelector = {
            {{- range $key, $value := .spec.distribution.common.nodeSelector }}
            "{{ $key }}" = "{{ $value }}"
            {{- end }}
          }
          tolerations = [
            {{- range $key, $value := .spec.distribution.common.tolerations }}
            {
              key = "{{ $value.key }}"
              value = "{{ $value.value }}"
              effect = "{{ $value.effect }}"
            },
            {{- end }}
          ]
        }
      }
    }
  }
 coredns_scheduling_patch_as_json = jsonencode(local.patch_data)
}

resource "null_resource" "patch_coredns" {
  triggers = {
    run_once = local.coredns_scheduling_patch_as_json
  }

  provisioner "local-exec" {
    command = "${var.kubectl_path} patch deployment/coredns -n kube-system -p '${local.coredns_scheduling_patch_as_json}'"
  }
}
