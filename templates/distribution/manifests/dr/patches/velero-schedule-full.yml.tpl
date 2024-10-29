# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

{{- if or (index .spec.distribution.modules.dr.velero.schedules "ttl") (and (index .spec.distribution.modules.dr.velero.schedules "cron") (index .spec.distribution.modules.dr.velero.schedules.cron "full")) }}
---
apiVersion: velero.io/v1
kind: Schedule
metadata:
  name: full
  namespace: kube-system
spec:
  {{- if and (index .spec.distribution.modules.dr.velero.schedules "cron") (index .spec.distribution.modules.dr.velero.schedules.cron "full") }}
  schedule: {{ .spec.distribution.modules.dr.velero.schedules.cron.full }}
  {{- end }}
  {{- if index .spec.distribution.modules.dr.velero.schedules "ttl" }}
  template:
    ttl: {{ .spec.distribution.modules.dr.velero.schedules.ttl }}
  {{- end }}
{{- end }}
