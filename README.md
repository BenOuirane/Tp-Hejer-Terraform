<a href="https://terraform.io">
    <img src="https://upload.wikimedia.org/wikipedia/fr/1/11/EPISEN.JPG" alt="Terraform logo" title="Terraform" align="right" height="100" />
</a>


# Tp-Hajeur-ING3-Terraform

# Exam : Terraform

- [Prérequis](#prérequis)
- [Références](#références)
- [Buts du projet](#buts-du-projet)
- [Procédure](#procédure)
- [Architecture finale simplifiée](#architecture-finale-simplifiée)
- [Diagramme de classe simplifiée](#Diagramme-de-classe-simplifiée)

## Prérequis
- Avoir un compte AWS
- Avoir une générer une clé dont le nom est **Key_AWS**
- Avoir créé un utilisateur avec les droits d'admin sur son compte AWS
- Ajouter les AWS_ACCESS_KEY_ID et AWS_SECRET_ACCESS_KEY dans le fichier terraform.tfvars de cette utilisateur sur votre machine
```
AWS_ACCESS_KEY="Put your access key here"
AWS_SECRET_KEY="put your secret key here"
```
- Génere la clé priver .ppk avec PuTTYgen et l'ajouter dans le dossier
- Changer la region qui est convenable a votre compte aws


## Références
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_stream
- https://github.com/easyawslearn/terraform-aws-kinesis

## Buts du projet
- Créer  une infrastructure de déployement(VPC, EC2, IAM) sur AWS à l'aide de terraform
- Créer  une infrastructure Data (AWS Kinesis Data Stream, Kinesis Firehose, Glue, Athena)  à l'aide de terraform
- Créer une application en Scala qui va récupérer un nombre X de tweets toutes les Y minutes
- Un schema d’infrastructure
- Un diagramme de séquence
- Un README (README.md)
- Déployer  l'application sur EC2 AWS
- Une vidéo
