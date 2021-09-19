variable "tags" {
  description = "Base tag set"
  type        = map(string)
}

variables "keyname" {
  description = "Demo SSH Key"
  type        = string
}