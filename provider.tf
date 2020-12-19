


############     SECRET KEY enregister dans le fichier terraform.tfvars  ############
############  afin qu'il soit pris en compte automatiquement  #######################
###################   par le moteur Terraform  ######################################



provider "aws" {
region = var.AWS_REGION
access_key = var.AWS_ACCESS_KEY
secret_key = var.AWS_SECRET_KEY
}