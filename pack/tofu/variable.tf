variable "blueprint_id" {
  type = string
}
variable "minimum_flap" {
  type = number
  description = "Minimum number of interface flaps to trigger anomaly "
}
