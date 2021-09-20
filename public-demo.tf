module "public-vpc" {
  count       = var.public_enable == true ? 1 : 0
  source      = "./public-vpc"
  keyname     = aws_key_pair.key_pair.key_name
  amazon2_ami = data.aws_ami.amazon_linux_2.id
  windows_ami = data.aws_ami.windows.id
  tags = {
    "Environment" = "Public"
  }
}

output "public_noNAT_instance" {
  value = var.private_enable == true ? module.public-vpc[0].public_noNAT_instance : "NotActive"
}

output "public_NAT_instance" {
  value = var.private_enable == true ? module.public-vpc[0].public_NAT_instance : "NotActive"
}

output "public_windows_instance" {
  value = var.private_enable == true ? module.public-vpc[0].public_windows_instance : "NotActive"
}


output "public_windows_ssm_command_winSyntax" {
  value = var.private_enable == true ? "aws ssm start-session --target ${module.public-vpc[0].public_windows_instance} --document-name AWS-StartPortForwardingSession --parameters 'portNumber'=['3389'],'localPortNumber'=['3389'] --region eu-west-1" : "NotActive"
}