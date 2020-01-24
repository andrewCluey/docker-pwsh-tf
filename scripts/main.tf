resource "null_resource" "test" {
    provisioner "local-exec" {
        command = "echo hello ${var.name}"
  }
}

variable "name" {
    type    = string
    default = "test-tf"  
}

