variable "blueprint_id" {
  type = string
}

variable "minimum_flap" {
  type = number
  description = "Minimum number of interface flaps to trigger anomaly "
}

variable "name" {
  type = string
  description = "Name: Please use only letters, numbers and _"
  validation {
    condition = strcontains(var.name, "/[^a-zA-Z0-9_]/") == false
    error_message = "The name must only have letters, numbers and _"
  }
  default = "Interface_Flap"
}


