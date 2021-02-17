# saka Infra as Code with Terraform

Automation with Terraform : saka Infra provision

## Intructions for Google Cloud Platform

### Create credentials.json

> https://console.cloud.google.com/apis/credentials/serviceaccountkey

### Save in you directory

> for example: etc/credentials/credentials.json

### Set ENV var GOOGLE_APPLICATION_CREDENTIALS

> export GOOGLE_APPLICATION_CREDENTIALS=../etc/credentials/credentials.json

### Initialize a Terraform working directory

> terraform init

### Create workspace of your enviroment dev, prd; for example: prd

> terraform workspace new prd

### Verify plan

> terraform plan -var-file enviroment/istio/env-istio.tfvars

### If plan is ok, Builds or changes infrastructure

> terraform apply -var-file enviroment/istio/env-istio.tfvars -auto-approve

### If need to destroy

> terraform destroy -var-file enviroment/istio/env-istio.tfvars -auto-approve

### In case of problems to destroy

> terraform plan -destroy -out=destroy.tfplan -var-file enviroment/istio/env-istio.tfvars
> terraform graph -verbose -draw-cycles destroy.tfplan -var-file enviroment/istio/env-istio.tfvars
> terraform apply destroy.tfplan -var-file enviroment/istio/env-istio.tfvars

#### Reference

> https://www.terraform.io/docs/providers/google/index.html
> https://cloud.google.com/community/tutorials/getting-started-on-gcp-with-terraform
> https://www.terraform.io/docs/providers/google/r/compute_firewall.html
> https://www.terraform.io/docs/modules/index.html
> https://github.com/GoogleCloudPlatform/terraform-google-examples/blob/master/example-custom-machine-types/
> https://www.terraform.io/docs/providers/google/r/container_cluster.html
> https://registry.terraform.io/modules/terraform-google-modules/startup-scripts/google/1.0.0