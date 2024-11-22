AWS_ACCESS_KEY_ID 
AWS_SECRET_ACCESS_KEY 

--POWERSHELL--
$env:AWS_ACCESS_KEY_ID="XXXX"
$env:AWS_SECRET_ACCESS_KEY="YYY"


--LINUX--
export AWS_ACCESS_KEY_ID="XXXX"
export AWS_SECRET_ACCESS_KEY="YYYY"

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

    Environment variables
    The terraform.tfvars file, if present.
    The terraform.tfvars.json file, if present.
    Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
    Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)
