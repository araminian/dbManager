# Generate random name for each purpose
{{- define "dbmanager.randomname" -}}
{{- $goal := index . 1 }}
{{- with index . 0 }}

{{- $rand := .Values.randomString | default (randAlphaNum 5) | lower }}

{{- printf "%s-%s-%s" .Release.Name $goal $rand | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}