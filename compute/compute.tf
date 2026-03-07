data "yandex_compute_image" "ubuntu-2204-latest" {
  family = "ubuntu-2204-lts"
}

# Загрузочный диск
resource "yandex_compute_instance" "first-vm" {

  count = length(var.instances)
  name = "${var.instances[count.index]}-${terraform.workspace}"

  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  folder_id = "b1g4ds9atfpt1vham7p0"

  resources {
    cores         = var.first_vm_compute_resources.cores
    core_fraction = var.first_vm_compute_resources.core_fraction
    memory        = var.first_vm_compute_resources.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2204-latest.id
    }
  }


  network_interface {
    subnet_id = values(module.yc-vpc.private_subnets)[0].subnet_id
  }

  metadata = {
    # "ubuntu" — это стандартный логин для образа Ubuntu в Yandex Cloud
    # После двоеточия мы вставляем содержимое твоего публичного ключа
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }

  allow_stopping_for_update = true

  depends_on = [
    yandex_compute_disk.secondary-disk-first-vm,
  ]

}

# Второй диск 
resource "yandex_compute_disk" "secondary-disk-first-vm" {

  count = length(var.instances)
  name     = "disk-name-${terraform.workspace}-${var.instances[count.index]}"
  type     = "network-hdd"
  zone     = "ru-central1-a"
  size     = 20 
  
}

