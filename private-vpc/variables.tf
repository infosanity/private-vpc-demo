variable "tags" {
  description = "Base tag set"
  type        = map(string)
}

variable "keyname" {
  description = "Demo SSH Key"
  type        = string
}

variable "amazon2_ami" {
  description = "latest Amazon2 AMI"
  type        = string
}