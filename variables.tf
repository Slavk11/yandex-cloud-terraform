variable "filename" {
  description = "Name of file for the output"
  type        = string
  default     = "output.txt"
}

variable "folder_id" {
  description = "Yandex cloud folder ID"
  type        = string
  default = "b1g4ds9atfpt1vham7p0"
}

variable "service_account" {
  description = "Service account"
  type        = string
  default = "tf-test-sa"
}

variable "state_bucket" {
  description = "Bucket for terraform state"
  type        = string
  default = "devopstrain-learning-bucket-100"

}

variable "second_bucket" {
  description = "Bucket to test import"
  type        = string
  default = "devopstrain-learning-bucket-3"
}

variable "subnet_params" {
  description = "VPC subnet params"
    type = object({
      zone    = string
      cidr = string
  })

  default = {
    zone = "ru-central1-a"
    cidr = "10.5.0.0/24"
  }
}

  variable "first_vm_compute_resources" {
    description = "Resources for first VM"
    type = object({
        cores = number
        core_fraction = number
        memory = number
    })
    default = {
        cores = 2
        core_fraction = 20
        memory = 2
    }
    validation {
    condition     = var.first_vm_compute_resources.core_fraction < 60
    error_message = "We don't want to pay for such powerful machine"
    }
  }

  variable "instances" {
      type    = list
      default = ["instance-1", "instance-2"]
    }