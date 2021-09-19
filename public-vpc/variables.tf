variable "tags" {
  description = "Base tag set"
  type        = map(string)
}

variable "keyname" {
  description = "SSH Keypair to use"
  type        = string
}