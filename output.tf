################# NETWORKING ####################
############## BEN OUIRANE Hajeur ###############

## VPC ##
output "aws_vpc_id" {
  value = aws_vpc.terraform-vpc.id
}


## SUBNET ##
output "aws_subnet_subnet_1" {
  value = aws_subnet.terraform-subnet_1.id
}


############     SECURITY GROUP     ##############
############## BEN OUIRANE Hajeur ################

output "aws_security_gr_id" {
  value = aws_security_group.terraform_private_sg.id
}

############     EC2               ##############
############## BEN OUIRANE Hajeur ################


output "instance_id_list"     { value = ["${aws_instance.terraform_wapp.*.id}"] }