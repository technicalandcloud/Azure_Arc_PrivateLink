# Azure Arc + Private Link Sandbox (Private Environment)

> ℹ️ This project is based on the community work from [Azure Arc Jumpstart](https://github.com/microsoft/azure_arc).  
> The Terraform code has been adapted from Jumpstart deployments to build a private environment integrating Azure Arc, AMPLS, and Private Link.

---

## 📦 Repository Structure

- `Terraform/`: Terraform scripts to deploy the full environment.
- `privatelink/artifacts/`: Supporting files (scripts, configurations, etc.)

---

## ✅ Prerequisites

- Azure CLI
- Terraform installed locally
- A **Service Principal** with `Contributor` role on a **subscription**
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


⏱️ After a few minutes:

- ✅ The **Azure Arc** resource will appear in the Azure portal  


---
## 🧪 Test Result

Once the deployment and configuration are complete:


