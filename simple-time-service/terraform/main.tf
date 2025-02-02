# main.tf
provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}
provider "kubernetes" {
  config_path = "~/.kube/config"  # Path to the kubeconfig file


}

# Create a VPC
resource "google_compute_network" "vpc" {
  name                    = "simple-time-service-vpc"
  auto_create_subnetworks = false
}

# Create 2 public subnets
resource "google_compute_subnetwork" "public_subnet_1" {
  name          = "public-subnet-1"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.gcp_region
  network       = google_compute_network.vpc.name
}

resource "google_compute_subnetwork" "public_subnet_2" {
  name          = "public-subnet-2"
  ip_cidr_range = "10.0.2.0/24"
  region        = var.gcp_region
  network       = google_compute_network.vpc.name
}

# Create 2 private subnets
resource "google_compute_subnetwork" "private_subnet_1" {
  name          = "private-subnet-1"
  ip_cidr_range = "10.0.3.0/24"
  region        = var.gcp_region
  network       = google_compute_network.vpc.name
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "private_subnet_2" {
  name          = "private-subnet-2"
  ip_cidr_range = "10.0.4.0/24"
  region        = var.gcp_region
  network       = google_compute_network.vpc.name
  private_ip_google_access = true
}

# Create a GKE cluster in the private subnets
resource "google_container_cluster" "gke_cluster" {
  name     = "simple-time-service-cluster"
  location = var.gcp_region

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.private_subnet_2.name

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "0.0.0.0/0"
      display_name = "public-access"
    }
  }

  node_pool {
    name       = "default-node-pool"
    node_count = 1

    node_config {
      machine_type = "e2-medium"
      disk_size_gb = 10
    }
  }
}

# Create a Kubernetes Deployment for the application
resource "kubernetes_deployment" "simple_time_service" {
  metadata {
    name = "simple-time-service"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "simple-time-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "simple-time-service"
        }
      }

      spec {
        container {
          name  = "simple-time-service"
          image = "veenarajpoot117/simpletimeservice:latest"
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

# Create a Kubernetes Service with a Load Balancer
resource "kubernetes_service" "simple_time_service" {
  metadata {
    name = "simple-time-service"
  }

  spec {
    selector = {
      app = "simple-time-service"
    }

    port {
      port        = 8080
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}

