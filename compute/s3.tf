// Создадим сервисный аккаунт
resource "yandex_iam_service_account" "sa" {
  name      = "tf-test-sa-${terraform.workspace}"
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




