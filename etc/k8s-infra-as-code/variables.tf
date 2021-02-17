variable "project" {
  default = "fabiojapa"
  type = string
}
variable "region" {
  default = "us-central1"
  type = string
}
variable "zone" {
  default = "us-central1-c"
  type = string
}
variable "network_name" {
  default = "default"
  type = string
}
variable "env" {
  type = string
}
variable "node_count" {
  default = 1
  type = number
}
variable "machine_type" {
  default = "custom-4-8192-ext"
  type = string
}
