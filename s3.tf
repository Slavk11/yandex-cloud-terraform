// Создадим сервисный аккаунт
resource "yandex_iam_service_account" "sa" {
  name      = "tf-test-sa"
  folder_id = var.folder_id
}

// Выдадим доступ для сервисного аккаунта
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
  folder_id = var.folder_id
}

// Создадим ключи доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

# Оставляем это только в ОДНОМ месте (например, в s3.tf)
resource "yandex_storage_bucket" "bucket-2" {
  # 1. Ключи доступа (взяли из первого куска)
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key

  # 2. Имя бакета (именно то, которое ждет система)
  bucket = "devopstrain-learning-bucket-100"
  acl    = "private"

  # 3. Правила жизненного цикла (взяли из второго куска)
  dynamic "lifecycle_rule" {
    for_each = var.bucket_lifecycle_rules
    content {
      id      = lifecycle_rule.value["id"]
      prefix  = lifecycle_rule.value["prefix"]
      enabled = true

      expiration {
        days = lifecycle_rule.value["expiration_days"]
      }
    }
  }

  versioning {
    enabled = false
  }

  tags = local.common_tags
}