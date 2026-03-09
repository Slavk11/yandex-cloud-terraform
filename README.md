# Infrastructure Documentation

## Module: compute
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.6 |
| <a name="requirement_external"></a> [external](#requirement\_external) | ~> 2.3.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_external"></a> [external](#provider\_external) | 2.3.5 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.7.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.191.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_yc-vpc"></a> [yc-vpc](#module\_yc-vpc) | git@github.com:terraform-yc-modules/terraform-yc-vpc.git | n/a |

## Resources

| Name | Type |
|------|------|
| [local_file.example](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [yandex_compute_disk.secondary-disk-first-vm](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_disk) | resource |
| [yandex_compute_instance.first-vm](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance) | resource |
| [yandex_iam_service_account.sa](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/iam_service_account) | resource |
| [yandex_iam_service_account_static_access_key.sa-static-key](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/iam_service_account_static_access_key) | resource |
| [yandex_resourcemanager_folder_iam_member.sa-editor](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/resourcemanager_folder_iam_member) | resource |
| [external_external.example](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [terraform_remote_state.networking](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [yandex_compute_image.ubuntu-2204-latest](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/compute_image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_lifecycle_rules"></a> [bucket\_lifecycle\_rules](#input\_bucket\_lifecycle\_rules) | n/a | `list` | <pre>[<br/>  {<br/>    "expiration_days": 30,<br/>    "id": "tmp",<br/>    "prefix": "tmp/"<br/>  },<br/>  {<br/>    "expiration_days": 90,<br/>    "id": "log",<br/>    "prefix": "log/"<br/>  }<br/>]</pre> | no |
| <a name="input_filename"></a> [filename](#input\_filename) | Name of file for the output | `string` | `"output.txt"` | no |
| <a name="input_first_vm_compute_resources"></a> [first\_vm\_compute\_resources](#input\_first\_vm\_compute\_resources) | Resources for first VM | <pre>object({<br/>        cores = number<br/>        core_fraction = number<br/>        memory = number<br/>    })</pre> | <pre>{<br/>  "core_fraction": 20,<br/>  "cores": 2,<br/>  "memory": 2<br/>}</pre> | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | Yandex cloud folder ID | `string` | `"b1g4ds9atfpt1vham7p0"` | no |
| <a name="input_instances"></a> [instances](#input\_instances) | n/a | `list(string)` | <pre>[<br/>  "instance-1",<br/>  "instance-2"<br/>]</pre> | no |
| <a name="input_second_bucket"></a> [second\_bucket](#input\_second\_bucket) | Bucket to test import | `string` | `"devopstrain-learning-bucket-3"` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | Service account | `string` | `"tf-test-sa"` | no |
| <a name="input_state_bucket"></a> [state\_bucket](#input\_state\_bucket) | Bucket for terraform state | `string` | `"devopstrain-learning-bucket-100"` | no |
| <a name="input_subnet_params"></a> [subnet\_params](#input\_subnet\_params) | VPC subnet params | <pre>object({<br/>      zone    = string<br/>      cidr = string<br/>  })</pre> | <pre>{<br/>  "cidr": "10.5.0.0/24",<br/>  "zone": "ru-central1-a"<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_file_contents"></a> [file\_contents](#output\_file\_contents) | Prints file content |

## Module: database
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.191.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_mdb_postgresql_cluster.my-pg](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_postgresql_cluster) | resource |
| [terraform_remote_state.networking](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

No inputs.

## Outputs

No outputs.

## Module: networking
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.191.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_network.main](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_network) | resource |
| [yandex_vpc_subnet.subnet-a](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network-id"></a> [network-id](#output\_network-id) | ID сети для кластера БД |
| <a name="output_subnet-id"></a> [subnet-id](#output\_subnet-id) | Return subnet ID |
