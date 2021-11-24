# Generate random name for each purpose
{{- define "dbmanager.randomname" -}}
{{- $rand := randAlphaNum 5 }}
{{- $goal := index . 1 }}
{{- with index . 0 }}
{{- printf "%s-%s-%s" .Release.Name $goal $rand | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}