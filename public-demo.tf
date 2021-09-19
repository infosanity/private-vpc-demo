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
  value = module.public-vpc[0].public_noNAT_instance
}

output "public_NAT_instance" {
  value = module.public-vpc[0].public_NAT_instance
}

output "public_windows_instance" {
  value = module.public-vpc[0].public_windows_instance
}


output "public_windows_ssm_command_winSyntax"{
  value = "aws ssm start-session --target ${module.public-vpc[0].public_windows_instance} --document-name AWS-StartPortForwardingSession --parameters 'portNumber'=['3389'],'localPortNumber'=['3389'] --region eu-west-1"
}