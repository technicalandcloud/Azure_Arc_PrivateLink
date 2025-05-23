# Azure Arc Jumpstart with Private Link (Terraform)

This Terraform configuration deploys a full Azure Arc-enabled infrastructure scenario using **Azure Virtual Network Gateway connections** between simulated **on-premises** and **Azure** environments. It includes support for **Azure Arc Private Link**, **Windows VM onboarding**, and **secure remote access via Azure Bastion**.

---

## 📌 Features

- Dual virtual network setup (on-prem & Azure)
- VNet-to-VNet VPN gateway connections
- Azure Arc Private Link Scope & Private Endpoint
- Windows Server VM onboarding to Azure Arc
- Custom Script Extension for automatic registration
- Azure Bastion host for RDP access
- Private DNS zone configuration
- Network security rules

---



## ✅ Prerequisites

- Azure CLI
- Terraform installed locally
- A **Service Principal** with `Contributor` role on a **subscription**
- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads)
- Azure Subscription
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- An Azure AD App registration with:
  - `Client ID`
  - `Client Secret`
  - `Tenant ID`
  - `Subscription ID`
  - `admin_username`
  - `admin_password`


---
### Quick SPN creation:

```
az login
subscriptionId=$(az account show --query id --output tsv)
az ad sp create-for-rbac -n "JumpstartArc" --role "Contributor" --scopes /subscriptions/$subscriptionId
```
---
## 🚀 Deployment with Terraform

Run the Terraform script by providing the following input variables:

- `client_id`
- `client_secret`
- `tenant_id`
- `subscription_id`
- `admin_username`
- `admin_password`
These identifiers are linked to the Main Service created earlier.

---
## 🧪 Test Result

Once the deployment and configuration are complete:

- ✅ The **Azure Arc** resource is successfully onboarded  

![image](https://github.com/user-attachments/assets/d5f16085-e324-4ea0-830a-a31219754d01)

- ✅ The **Azure Arc PrivateLink** is in place 
![image](https://github.com/user-attachments/assets/518a7ae5-cb37-40e8-8c27-b3d83c20a60d)


