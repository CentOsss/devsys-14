# Provider
provider "yandex" {
  cloud_id  = "${var.yandex_cloud_id}"
  folder_id = "${var.yandex_folder_id}"
  zone = "ru-central1-a"
}

# Instance

resource "yandex_compute_instance" "node01" {
  name                      = "node01"
  zone                      = "ru-central1-a"
  hostname                  = "node01.cloud"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }


  boot_disk {
    initialize_params {
      image_id    = "${var.centos-7}"
      name        = "root-node01"
      type        = "network-nvme"
      size        = "30"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default.id}"
    nat       = true
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
}
