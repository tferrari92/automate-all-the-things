# Prepare backend for Azure
===
az group create --name terraform-state-rg --location westeurope
az storage account create --name automatethingandrei --resource-group terraform-state-rg --location westeurope --sku Standard_LRS --encryption-services blob --min-tls-version TLS1_2
az storage container create   --name terraform-state   --account-name automatethingandrei   --public-access off

TBH: I would suggest creating backend for AWS with similar approach (CloudFormation or AWS CLI instead of using Terraform).
And in the deletion step we also should delete created storage account.

# Costs
===
AKS+NAT+3REDIS for 6 hours ~ $2,7 (East US)

# Terraform
===
I have prepared similar Azure files with slight differences:
- There is no a virtual machine (didn't get an idea - why we need it at all).
- We can't create cheap Redis without authentication that could be connected to the virtual network, so the app is not actually working. Redis Premium SKU is pretty expensive.
- Moreover, we can't set up Redis password, so next tasks are also a bit more complex (with passing Redis's password as a secret).
- Network Security group is really insecure (* to *), so it could be improved a bit.
# Github Actions
- AKS ingress doesn't have hostname, so I have to change pipeline to check an ip instead of hostname.
- For integration with Azure I reused OIDC, there are good guide on the Github Documentation portal.
- I was too lazy for combining pipelines, so there are separate pipelines for Azure infrastructure that were tested at least once
# Python
- Script should be modified to update my files (workflows and terraform/azure/*.tf)