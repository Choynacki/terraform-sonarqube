Procedure:

az login
az account set --subscription 28b1472f-2e08-47fe-a15e-7aab569ffe07
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"