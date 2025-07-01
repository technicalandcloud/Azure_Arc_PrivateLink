# Azure Arc with Private Link (Terraform)

This Terraform configuration deploys a full Azure Arc-enabled infrastructure scenario using **Azure Virtual Network Gateway connections** between simulated **on-premises** and **Azure** environments. It includes support for **Azure Arc Private Link**, **Windows VM onboarding**, and **secure remote access via Azure Bastion**.

> ℹ️ This project is based on the community work from [Azure Arc Jumpstart](https://github.com/microsoft/azure_arc).  

## 📌 Features

- Dual virtual network setup (on-prem & Azure)
- VNet-to-VNet VPN gateway connections
- Azure Arc Private Link Scope & Private Endpoint
- Windows Server VM onboarding to Azure Arc
- Custom Script Extension for automatic registration
- Azure Bastion host for RDP access
- Private DNS zone configuration
- Network security rules

![Arc Resource Screenshot](./assets/Architecture.png)


## ✅ Prerequisites

- Azure CLI
- Terraform installed locally
- A **Service Principal** with `Contributor` role on a **subscription**
- Azure Subscription
- An App registration with:
  - `Client ID`
  - `Client Secret`
  - `Tenant ID`
  - `Subscription ID`
  - `admin_username`
  - `admin_password`

# ✔ Service Principal Setup
```
# Sign in to Azure
az login

# Retrieve the subscription ID
$subId = az account show --query id -o tsv

# Create the service principal
$sp = az ad sp create-for-rbac `
    --name "JumpstartArc" `
    --role "Contributor" `
    --scopes "/subscriptions/$subId" `
    --output json | ConvertFrom-Json
# Manually construct the spn.json file
$spn = [PSCustomObject]@{
    clientId       = $sp.appId
    clientSecret   = $sp.password
    subscriptionId = $subId
    tenantId       = $sp.tenant
}

# Save as a JSON file
$spn | ConvertTo-Json -Depth 10 | Out-File -FilePath "spn.json" -Encoding utf8

```
Then load the credentials:
```
$spn = Get-Content ./spn.json | ConvertFrom-Json

# ARM_* = used by Terraform provider
$env:ARM_CLIENT_ID       = $spn.clientId
$env:ARM_CLIENT_SECRET   = $spn.clientSecret
$env:ARM_SUBSCRIPTION_ID = $spn.subscriptionId
$env:ARM_TENANT_ID       = $spn.tenantId

# TF_VAR_* = used by Terraform variable injection
$env:TF_VAR_client_id       = $env:ARM_CLIENT_ID
$env:TF_VAR_client_secret   = $env:ARM_CLIENT_SECRET
$env:TF_VAR_subscription_id = $env:ARM_SUBSCRIPTION_ID
$env:TF_VAR_tenant_id       = $env:ARM_TENANT_ID
```
# Deploy the infrastructure using Terraform
```
terraform init
terraform apply -auto-approve
```

## 🧪 Test Result

Once the deployment and configuration are complete:

- ✅ The **Azure Arc** resource is successfully onboarded  

![Arc Resource Screenshot](./assets/azure_arc_finally.png)

- ✅ The **Azure Arc PrivateLink** is in place 
![Arc Resource Screenshot](./assets/PrivateLink.png)

🧹 Cleanup / Destruction

When using `terraform destroy`, you may encounter issues related to the Azure Arc onboarding process:

1. ❗ **Hybrid Machine resource not deleted**
   - Even after destroying the VM, the associated `Microsoft.HybridCompute/machines/<vm-name>` resource may still exist.
   - This resource must be deleted manually via Azure CLI:

     ```bash
     az resource delete \
       --ids "/subscriptions/<your-subscription-id>/resourceGroups/Arc-Azure-RG/providers/Microsoft.HybridCompute/machines/<vm-name>"
     ```

2. ❗ **Manual deletion of resource groups may be required**
   - In some cases, Terraform may be unable to delete the resource group due to lingering Arc-related resources (e.g., extensions, hybrid compute registrations).
   - You can manually delete the resource groups from the [Azure Portal](https://portal.azure.com) or use the CLI:

     ```bash
     az group delete --name Arc-Azure-RG --yes --no-wait
     az group delete --name Arc-OnPrem-RG --yes --no-wait
     ```

🔐 Use this option with caution, especially in production environments.

