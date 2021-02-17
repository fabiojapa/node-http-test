provider "google" {
  project     = var.project
  region      = var.region
}

terraform {
  backend "gcs" {
    bucket  = "saka-dev-bucket"
    prefix  = "terraform/state/k8s/saka-k8s-nginx"
  }
}

module "saka-k8s" {
  source          = "./modules/saka-k8s" 

  region          = var.region
  zone            = var.zone

  machine_type    = var.machine_type
  disk_size_gb    = 50

  env             = var.env
  node_tags       = ["k8s", "docker"]

  k8s-node-count  = var.node_count
  k8s-max-node-count = var.node_count

  network_name    = var.network_name

  # Wait for resources and associations to be created
  depends_on_network = []

}