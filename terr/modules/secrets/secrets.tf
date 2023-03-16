
#data source to retrive the info from the google secretes
data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${var.host}:443"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}


#reciving some secretes
data "google_secret_manager_secret_version" "tls-crt" {
  secret = var.google_secretes.bitnami_tls-crt
}

data "google_secret_manager_secret_version" "tls-key" {
  secret = var.google_secretes.bitnami_tls-key
}

data "google_secret_manager_secret_version" "sshPrivateKey2" {
  secret = var.google_secretes.repo_sshPrivateKey2
}

data "google_secret_manager_secret_version" "sshPrivateKey1" {
  secret = var.google_secretes.repo_sshPrivateKey1
}

## uploading
resource "kubernetes_namespace" "sealed-secrets" {
  metadata {
    name = "sealed-secrets" ### must be this value for the auto key to work
  }
  depends_on = [
    var.node_pull
  ]
}


# Sealed secrets keys
resource "kubernetes_secret" "sealed-secrets-key" {
  metadata {
    name      = "sealed-secrets-key" ### must be this value for the auto key to work
    namespace = "sealed-secrets"     ### must be this value for the auto key to work
  }
  data = {
    "tls.crt" = data.google_secret_manager_secret_version.tls-crt.secret_data
    "tls.key" = data.google_secret_manager_secret_version.tls-key.secret_data
  }
  type       = "kubernetes.io/tls"
  depends_on = [kubernetes_namespace.sealed-secrets]
}



### Repositories configuration for argo ###
resource "kubernetes_secret" "gitops_repo1" {
  metadata {
    name      = var.gitops_repo1.name
    namespace = var.argo_namespace

    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }
  data = {
    "type"          = "git"
    "url"           = var.gitops_repo1.url
    "sshPrivateKey" = data.google_secret_manager_secret_version.sshPrivateKey1.secret_data
  }
  type = "Opaque"

  depends_on = [
    kubernetes_namespace.sealed-secrets
  ]
}

resource "kubernetes_secret" "gitops_repo2" {
  metadata {
    name      = var.gitops_repo2.name
    namespace = "argo"

    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }
  data = {
    "type"          = "git"
    "url"           = var.gitops_repo2.url
    "sshPrivateKey" = data.google_secret_manager_secret_version.sshPrivateKey2.secret_data
  }
  type = "Opaque"

  depends_on = [
    kubernetes_namespace.sealed-secrets
  ]
}