terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

provider "kubectl" {
  host                   = "https://${var.host}:443"
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host                   = "https://${var.host}:443"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = "https://${var.host}:443"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}

data "google_client_config" "default" {}

resource "kubernetes_namespace" "argo" {
  metadata {
    name = var.argo_namespace
  }
  depends_on = [
    var.node_pull
  ]
}

resource "kubernetes_namespace" "application" {
  metadata {
    name = var.application_namespace
  }
  depends_on = [
    var.node_pull
  ]
}


resource "helm_release" "argo" {
  name = var.argocd_helm_chart.release_name

  repository = var.argocd_helm_chart.repository
  chart      = var.argocd_helm_chart.chart
  version    = var.argocd_helm_chart.version
  namespace  = var.argo_namespace

  values = [
    "${file("${var.argocd_helm_chart.values_file}")}"
  ]

  depends_on = [
    kubernetes_namespace.argo
  ]
}


data "kubectl_file_documents" "docs" {
  content = file("${var.app-of-apps-file}")
}

resource "kubectl_manifest" "apps" {
  for_each  = data.kubectl_file_documents.docs.manifests
  yaml_body = each.value
  depends_on = [
    helm_release.argo
  ]
}