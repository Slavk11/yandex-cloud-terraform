terraform {
  backend "s3" {
    bucket    = "devopstrain-learning-bucket-hex"
    key       = "terraform/yandex-cloud-db/state" # Ключ для САМОЙ БАЗЫ
    region    = "ru-central1"
    endpoints = { s3 = "https://storage.yandexcloud.net" }
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }

  required_providers {
    yandex = { source = "yandex-cloud/yandex" }
  }
}

provider "yandex" {}

data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket    = "devopstrain-learning-bucket-hex"
    key       = "terraform/yandex-cloud-vpc/state" # Ключ СЕТЕВОГО проекта
    endpoints = { s3 = "https://storage.yandexcloud.net" }
    region                      = "ru-central1"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true # Самая важная для этой ошибки
    skip_s3_checksum            = true
  }
}

resource "yandex_mdb_postgresql_cluster" "my-pg" {
  name        = "my-db-cluster"
  environment = "PRESTABLE"
  
  # Используем network-id из первого проекта
  network_id  = data.terraform_remote_state.networking.outputs.network-id

  config {
    version = "15"
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }
  }

  database {
    name  = "my_app_db"
    owner = "dbadmin"
  }

  user {
    name     = "dbadmin"
    password = "my_secure_password119027" 
  }

  host {
    zone      = "ru-central1-a"
    # Используем subnet-id из первого проекта
    subnet_id = data.terraform_remote_state.networking.outputs.subnet-id
  }
}