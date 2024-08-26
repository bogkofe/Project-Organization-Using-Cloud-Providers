resource "yandex_vpc_network" "develop" {
  name = "develop"
}

resource "yandex_vpc_subnet" "public" {
  name           = var.public_vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.public_default_cidr
}

resource "yandex_vpc_subnet" "private" {
  name           = var.private_vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.private_default_cidr
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
}

resource "yandex_compute_instance" "nat-instance" {
  name        = var.nat_ci_name
  platform_id = "standard-v1"
  zone        = var.default_zone
  resources {
    cores         = var.vms_resources["nat"].cores
    memory        = var.vms_resources["nat"].memory
    core_fraction = var.vms_resources["nat"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id      = yandex_vpc_subnet.public.id
    ip_address     = var.pub_ip_address
    nat            = true
  }

  metadata = var.metadata["metadata"]
}

resource "yandex_compute_instance" "public-vm" {
  name        = var.pub_ci_name
  platform_id = "standard-v1"
  zone        = var.default_zone
  resources {
    cores         = var.vms_resources["pub"].cores
    memory        = var.vms_resources["pub"].memory
    core_fraction = var.vms_resources["pub"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = var.ubuntu_image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id      = yandex_vpc_subnet.public.id
    nat            = true
  }

  metadata = var.metadata["metadata"]
}

resource "yandex_compute_instance" "private-vm" {
  name        = var.priv_ci_name
  platform_id = "standard-v1"
  zone        = var.default_zone
  resources {
    cores         = var.vms_resources["priv"].cores
    memory        = var.vms_resources["priv"].memory
    core_fraction = var.vms_resources["priv"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = var.ubuntu_image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id      = yandex_vpc_subnet.private.id
    ip_address     = var.priv_ip_address
  }

  metadata = var.metadata["metadata"]

  depends_on = [yandex_vpc_route_table.nat-instance-route]
}

resource "yandex_vpc_route_table" "nat-instance-route" {
  name                 = "nat-instance-route"
  network_id           = yandex_vpc_network.develop.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = yandex_compute_instance.nat-instance.network_interface.0.ip_address
  }
}