variable "env" {
  default = "env"
}

variable "region" {
  default = "us-east1"
}

variable "network_cidr" {
  default = "10.127.0.0/20"
}

variable "network_name" {
  default = "saka-network"
}

variable "firewall_name" {
  default = "saka-firewall"
}

variable "node_tags" {
  description = "Additional compute instance network tags for the nodes."
  type        = list(string)
  default     = ["saka", "db", "k8s", "docker"]
}