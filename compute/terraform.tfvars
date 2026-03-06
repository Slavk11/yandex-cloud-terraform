filename        = "output.txt"
folder_id       = "b1g4ds9atfpt1vham7p0"
service_account = "tf-test-sa"
state_bucket    = "devopstrain-learning-bucket-100" 
second_bucket   = "devopstrain-learning-bucket-3" 
subnet_params = {
  zone = "ru-central1-a"
  cidr = "10.5.0.0/24"
}
first_vm_compute_resources = {
  cores         = 2
  core_fraction = 20
  memory        = 2
}