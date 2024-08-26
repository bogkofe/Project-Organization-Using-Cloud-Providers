resource "yandex_kms_symmetric_key" "kms_key" {
  name      = "my-kms-key"
  folder_id = var.folder_id
  rotation_period = "8760h"
  description = "KMS key for bucket"
}

resource "yandex_storage_bucket" "purpurikedze" {
  access_key   = var.access_key
  secret_key   = var.secret_key
  bucket       = "purpurikedze"
  acl          = "public-read"
  force_destroy = true
  max_size     = 1000000
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
        kms_master_key_id = yandex_kms_symmetric_key.kms_key.id
      }
    }
  }
  website {
    index_document = "index.html"
  }
}
