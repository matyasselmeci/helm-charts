{{/* vim: set filetype=mustache:et:sw=2:sts=2 */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "osdf-origin.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "osdf-origin.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "osdf-origin.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Check image.registry -- only specific ones are allowed.
Use "hub.opensciencegrid.org" as the default.
*/}}
{{- define "osdf-origin.origin-registry" -}}
  {{- with .Values.image -}}
    {{- if eq (default "hub.opensciencegrid.org" .registry) "hub.opensciencegrid.org" -}}
      hub.opensciencegrid.org
    {{- else if eq .registry "docker.io" -}}
      docker.io
    {{- else -}}
      {{- fail "Only the 'hub.opensciencegrid.org' and 'docker.io' container registries are allowed" -}}
    {{- end -}}
  {{- end -}}
{{- end -}}


{{/*
Check Containers.Origin.Organization -- only specific ones are allowed.
Use "opensciencegrid" as the default.
*/}}
{{- define "osdf-origin.origin-organization" -}}
  {{- with .Values.image -}}
    {{- if eq (default "opensciencegrid" .organization) "opensciencegrid" -}}
      opensciencegrid
    {{- else if eq .organization "matyasosg" -}}
      matyasosg
    {{- else -}}
      {{- fail "Only the 'opensciencegrid' and 'matyasosg' organizations are allowed" -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

