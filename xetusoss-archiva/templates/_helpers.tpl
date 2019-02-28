{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "archiva.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "archiva.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the proxy base url from the proxy.* values
*/}}
{{- define "archiva.proxyBaseUrl" -}}
{{- $proto := .Values.proxy.proto -}}
{{- $host := .Values.proxy.hostname -}}
{{- $path := default "" .Values.proxy.pathPrefix -}}
{{- if .Values.proxy.customPort -}}
  {{- $port := int .Values.proxy.customPort -}}
  {{- printf "%s://%s:%d%s" $proto $host $port $path -}}
{{ else }}
  {{- printf "%s://%s%s" $proto $host $path -}}
{{- end -}}
{{- end -}}

{{/*
Convert the JVM options array into a string
*/}}
{{- define "archiva.jvmExtraOptsStr" -}}
{{- if (.Values.advanced.jvmExtraOpts) -}}
{{- range .Values.advanced.jvmExtraOpts }} {{ . }}{{ end -}}
{{- end -}}
{{- end -}}
