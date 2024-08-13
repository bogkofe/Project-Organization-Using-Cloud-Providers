###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "public_default_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "private_default_cidr" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "public_vpc_name" {
  type        = string
  default     = "public"
  description = "VPC network & public subnet name"
}

variable "private_vpc_name" {
  type        = string
  default     = "private"
  description = "VPC network & private subnet name"
}

variable "nat_ci_name" {
  type        = string
  default     = "nat-instance"
  description = "nat yandex_compute_instance name"
}

variable "pub_ci_name" {
  type        = string
  default     = "public-vm"
  description = "public yandex_compute_instance name"
}

variable "priv_ci_name" {
  type        = string
  default     = "private-vm"
  description = "private yandex_compute_instance name"
}

variable "pub_ip_address" {
  type        = string
  default     = "192.168.10.254"
  description = "IP address for the NAT instance"
}

variable "priv_ip_address" {
  type        = string
  default     = "192.168.20.10"
  description = "IP address for the private instance"
}

variable "image_id" {
  type        = string
  default     = "fd80mrhj8fl2oe87o4e1"  
  description = "Image ID"
}

variable "ubuntu_image_id" {
  type        = string
  default     = "fd864gbboths76r8gm5f"  
  description = "Ubuntu_Image ID"
}

variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  default = {
    nat = {
      cores         = 2
      memory        = 1
      core_fraction = 5
    },
    pub = {
      cores         = 2
      memory        = 2
      core_fraction = 5
    },
    priv = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
}

variable "metadata" {
  type = map(object({
    serial-port-enable  = number
    ssh-keys            = string
  }))
  default = {
    metadata = {
      serial-port-enable = 1
      ssh-keys         = "admins:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8hSq3x1m8WIuqKY5kuU70v6+h49Qh8lsr+5cZ6Ow84nxpsg8LTNjBTmFcROJ6kXRc/Eh/RWtCQLahFsZ8bmNseipqF8Jp87Y9ImL4czW3Ufhd50wFxeMFtZKH7zyFXE9y+cTmP8oosJml0XkllWh25/OT+Y0mxG08G7DF7eT0p9KLlUXne1Ezc1SY6Ncpuw0UVhyYTT9Qq8FFRI86CMxAXwooZ8E9PeLB4AUjlyqjHv6vwUa1GVWcuu3UTrFXz1hy/BgH1bWjgVdUr6P4FnAQdCxHE9B8FP6efOfBH1v9zdc0b5JxQg8J6O6BMeCw+A7POHtiSvkHjvwjksBZpXbMAGiU9t0V/OpilVHUnZqeEvkNUEbX6BHkcg6Zo2OwOgrHKDii3c01WT6ZTFbOx0bS3LmcLCXqkaZkqE5MQL6GEnMcWtib9O5URTbHmNgAYBij8eAOJQyjXbJ5vr+YBHpmbUZr9lmNSMkWNQk32nE6szS+7QhRzj8ziqjSJvtEKKM= admins@s1"
    }
  }
}

