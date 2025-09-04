terraform {
  required_providers {
    lxd = {
      source  = "terraform-lxd/lxd"
      version = "~> 2.0"
    }
  }
  required_version = ">= 1.0"
}

# Configure the LXD Provider
provider "lxd" {
  # Use local LXD daemon via unix socket
}

# Variables
variable "vm_name" {
  description = "Name of the LXD VM"
  type        = string
  default     = "test-vm"
}

variable "image" {
  description = "LXD image to use"
  type        = string
  default     = "ubuntu:24.04"
}

# Create a profile for our VM with cloud-init support
resource "lxd_profile" "test_profile" {
  name = "test-profile"

  config = {
    "user.user-data" = file("${path.module}/cloud-init.yml")
  }

  device {
    name = "root"
    type = "disk"
    properties = {
      path = "/"
      pool = "default"
      size = "5GB"
    }
  }

  device {
    name = "eth0"
    type = "nic"
    properties = {
      network = "lxdbr0"
      name    = "eth0"
    }
  }
}

# Create the LXD VM (system container with VM-like behavior and cloud-init)
resource "lxd_instance" "test_vm" {
  name      = var.vm_name
  image     = var.image
  type      = "container"
  profiles  = [lxd_profile.test_profile.name]

  config = {
    "boot.autostart"      = "true"
    "security.nesting"    = "true"
    "security.privileged" = "false"
  }
}
