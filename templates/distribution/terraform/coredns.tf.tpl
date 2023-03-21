locals {
  patch_data = {
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
}

resource "null_resource" "patch_coredns" {
  triggers = {
    run_once = jsonencode(local.patch_data)
  }

  provisioner "local-exec" {
    command = "${var.kubectl_path} patch deployment/coredns -n kube-system -p '${jsonencode(local.patch_data)}'"
  }
}
