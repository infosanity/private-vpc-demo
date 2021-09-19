variable "tags" {
  description = "Base tag set"
  type        = map(string)
}

variable "keyname" {
  description = "SSH Keypair to use"
  type        = string
}

variable "amazon2_ami" {
  description = "latest Amazon2 AMI"
  type        = string
}

variable "windows_ami" {
  description = "latest Windows Server 2016 Base AMI"
  type        = string
}
