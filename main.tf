       
      
################# NETWORKING ####################
############## BEN OUIRANE Hajeur ###############
     

## Create VPC ##
resource "aws_vpc" "terraform-vpc" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "terraform-demo-vpc"
  }
}



## Create Subnets ##
resource "aws_subnet" "terraform-subnet_1" {
  vpc_id     = aws_vpc.terraform-vpc.id
  cidr_block = "10.0.0.0/24"
  

  tags = {
    Name = "terraform-subnet_1"
  }
}


## NAT ##
resource "aws_eip" "nat_Hajeur" {
  vpc = true
}

resource "aws_nat_gateway" "nat_Hajeur" {
  allocation_id = aws_eip.nat_Hajeur.id
  subnet_id     = aws_subnet.terraform-subnet_1.id
}


# ROUTE for public network
resource "aws_route_table" "public_routetable_Hajeur" {
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "Public Routetable Exam Hajeur"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = "vpc_Exam_Hajeur"
  }
}

resource "aws_route" "public_route_Exam_Hajeur" {
  route_table_id         = aws_route_table.public_routetable_Hajeur.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}


resource "aws_route_table_association" "public_subnet_a" {
  subnet_id      = aws_subnet.terraform-subnet_1.id
  route_table_id = aws_route_table.public_routetable_Hajeur.id
}

##################################################
############     SECURITY GROUP     ##############
############    Ben OUIRANE Hajeur  ##############
##################################################


## Security Group##
resource "aws_security_group" "terraform_private_sg" {
  description = "Allow limited inbound external traffic"
  vpc_id      = aws_vpc.terraform-vpc.id
  name        = "terraform_ec2_private_sg"

  ingress {
    description = "ssh from VPC"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
  }

  ingress {
    description = "http from VPC"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8080
    to_port     = 8080
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
  }

  egress {
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
  }

  tags = {
    Name = "ec2-private-sg"
  }
}


##################################################
############          ECS           ##############
############    Ben OUIRANE Hajeur  ##############
##################################################



## EC2 ##

resource "aws_instance" "terraform_wapp" {
    ami = var.AWS_AMIS[var.AWS_REGION]
    instance_type = "t2.micro"
    vpc_security_group_ids =  [ "${aws_security_group.terraform_private_sg.id}" ]
    subnet_id = aws_subnet.terraform-subnet_1.id
    key_name= "Key_AWS"
    
    associate_public_ip_address = true
 //   user_data     = file("scripts/init_public_machine.sh")
    tags = {
      Name              = "Pipline-Exam-Hejer"
      Environment       = "development"
      Project           = "DEMO-TERRAFORM"
    }
}




##################################################
############    DATA CODE           ##############
############    Ben OUIRANE Hajeur  ##############
##################################################






## Bucket to save data came from FireHose##


resource "aws_s3_bucket" "bucket" {
  bucket = "hejer-bucket"
  acl    = "private"
}

resource "aws_glue_catalog_database" "aws_glue_database" {
  name = "${var.app_name}-glue-database"

  
}



## FireHose Stream ##


resource "aws_kinesis_firehose_delivery_stream" "firehose_stream" {
  name        = "${var.app_name}_firehose_delivery_stream"
  destination = "s3"

  kinesis_source_configuration {
    kinesis_stream_arn = aws_kinesis_stream.kinesis_stream.arn
    role_arn           = aws_iam_role.firehose_role.arn
  }

  //refer the more s3 configuration at https://docs.aws.amazon.com/firehose/latest/APIReference/API_ExtendedS3DestinationConfiguration.html
  ## S3 to store DATA  ##
  s3_configuration {
    role_arn        =  aws_iam_role.firehose_role.arn
    bucket_arn      =  var.s3_bucket_arn
    
  }
}





## S3 to save request result ##

resource "aws_s3_bucket" "tony" {
  bucket = "tfouh"
}

## Athena Work Group ##

resource "aws_athena_workgroup" "primary" {
  name       = "primary2"
  depends_on = [aws_s3_bucket.tony]
  configuration {
    enforce_workgroup_configuration    = false
    publish_cloudwatch_metrics_enabled = true

    result_configuration {
      output_location = "s3://${aws_s3_bucket.tony.bucket}/"

      encryption_configuration {
        encryption_option = "SSE_S3"
      }
    }
  }
}



##  Crawler ##

resource "aws_glue_crawler" "crawler-episen" {
  database_name =  aws_glue_catalog_database.aws_glue_database.name
  name          = "crawler-episen"
  role          =  aws_iam_role.glue_crawler_role.arn
  
  configuration = <<EOF
{
   "Version": 1.0,
   "CrawlerOutput": {
      "Partitions": { "AddOrUpdateBehavior": "InheritFromTable" }
   }
}
EOF

  s3_target {
    path = "s3://${var.s3_bucket_path}/2020/12/11/01"
  }
}







