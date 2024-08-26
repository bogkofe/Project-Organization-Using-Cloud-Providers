#resource "yandex_storage_bucket" "purpurikedze" {
#  access_key = var.access_key
#  secret_key = var.secret_key
#  bucket     = "purpurikedze"
#  acl        = "public-read"
#  force_destroy = "true"
#  max_size   = 1000000
#  website {
#    index_document = "index.html"
#  }
#}

resource "yandex_storage_object" "image_file" {
  access_key = var.access_key
  secret_key = var.secret_key
 bucket = "purpurikedze"
  key    = "cat.png"
  source = "../files/cat.png"
  acl    = "public-read"
  depends_on = [
    yandex_storage_bucket.purpurikedze
  ]
}

resource "yandex_compute_instance_group" "lamp-vm-group" {
  name               = "lamp-vm-group"
  folder_id          = var.folder_id
  service_account_id = var.service_account_id
  instance_template {
    platform_id = "standard-v1"
    resources {
      cores         = 2
      memory        = 2
      core_fraction = 5
    }
    boot_disk {
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
      }
    }
    network_interface {
      subnet_ids = [yandex_vpc_subnet.public.id]
    }
    metadata = merge(var.metadata["metadata"], {
      user-data = file("user_data.yaml")
    })
  }
  scale_policy {
    fixed_scale {
      size = 3
    }
  }
  allocation_policy {
    zones = [var.default_zone]
  }
  deploy_policy {
    max_unavailable = 2
    max_creating    = 3
    max_expansion   = 3
  }
}

resource "yandex_lb_target_group" "lamp-target-group" {
  name       = "lamp-target-group"
  region_id  = "ru-central1"

  target {
    address     = yandex_compute_instance_group.lamp-vm-group.instances[0].network_interface[0].ip_address
    subnet_id   = yandex_vpc_subnet.public.id
  }

    target {
    address     = yandex_compute_instance_group.lamp-vm-group.instances[1].network_interface[0].ip_address
    subnet_id   = yandex_vpc_subnet.public.id
  }

    target {
    address     = yandex_compute_instance_group.lamp-vm-group.instances[2].network_interface[0].ip_address
    subnet_id   = yandex_vpc_subnet.public.id
  }
}

resource "yandex_lb_network_load_balancer" "nlb" {
  name = "network-load-balancer"

  listener {
    name       = "http-listener"
    port       = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.lamp-target-group.id
    healthcheck {
      name                = "http-health-check"
      http_options {
        port     = 80
        path     = "/index.html"
      }
    }
  }
}
