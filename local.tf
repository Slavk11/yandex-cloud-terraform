data "external" "example" {
  program = ["echo", "{\"name\": \"somename\", \"desc\": \"somedesc\"}"]

}

resource "local_file" "example" {
  filename = "output.txt"
  content = templatefile("template.tpl", {
    key1 = data.external.example.result.name
    key2 = data.external.example.result.desc
  })
}

locals {
  common_tags = {
    Project     = "DevOps-Training"
    Environment = "Learning"
    Terraform   = "true"
  }
}