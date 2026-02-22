data "yandex_compute_image" "ubuntu-2204-latest" {
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "first-vm" {
  name        = "first-vm"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    core_fraction = 20
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "${data.yandex_compute_image.ubuntu-2204-latest.id}"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-a.id}"
    nat = true
  }

  metadata = {
    # "ubuntu" — это стандартный логин для образа Ubuntu в Yandex Cloud
    # После двоеточия мы вставляем содержимое твоего публичного ключа
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}