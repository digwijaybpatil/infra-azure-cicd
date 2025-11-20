<!-- ...existing code... -->
# infra-azure-cicd

Lightweight, production-minded Terraform layout to deploy a two‑tier app on Azure:
- Frontend → web VM(s)
- Backend → app VM(s)
- Data → MySQL Flexible Server in a dedicated data subnet
- Secure access → Azure Bastion (optional)
- Remote state → Azure Storage Account
- Secrets → Azure Key Vault
- Full networking: VNet, subnets, NICs, NSGs, PIPs, Private DNS for MySQL
- CI/CD ready (Azure DevOps pipelines included)

---

## Architecture (at a glance)
Simple logical diagram:

        Internet
           |
        Public IPs
      /    |     \
    Bastion  Web VM(s)  App VM(s)
      |        |           |
    AzureBastionSubnet  web subnet  app subnet
                         \          /
                          VNet
                           |
                       data subnet (MySQL Flexible Server)
                           |
                   privatelink.mysql.database.azure.com (Private DNS)

Key pieces:
- VNet with subnets: AzureBastionSubnet, web, app, data (delegated for MySQL)
- Per-VM NSG / NIC / (optional) Public IP
- Bastion host (commented by default; enable via modules)
- MySQL Flexible Server + DBs in delegated data subnet + Private DNS zone
- Key Vault used for SSH keys and DB passwords
- Storage Account used for Terraform remote state

---

## Highlights / Features
- Modular: modules for rg, vnet, snet, nsg, nic, pip, bastion, vm, mysql, private DNS
- Dynamic VM provisioning: var.vms map drives NIC, PIP, NSG and VM creation (for_each)
- Secure secret handling: data.azurerm_key_vault reads existing Key Vault secrets
- MySQL uses delegated subnet + privatelink for private connectivity
- CI/CD: PR validation, dev auto-apply, prod plan+apply pipelines included

---

## Quickstart (local)
1. Login & subscription
   - az login
   - az account set --subscription <id>
2. Initialize with remote backend
```bash
terraform init \
  -backend-config="resource_group_name=rg-digwi-terraform-remote" \
  -backend-config="storage_account_name=stgdigwiterraformstate" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=dev.terraform.tfstate"
```
3. Validate, plan, apply
```bash
terraform validate
terraform plan -var-file="env/dev/dev.tfvars" -out=tfplan
terraform apply -auto-approve tfplan
```

---

## Key variables & maps
- var.vms — map of VM definitions (key = logical name e.g., web, app)
  - attributes: subnet_name, public_ip_enabled, vm_size, vm_admin_username, source_image_reference, os_disk, security_rules
- var.mysql_servers — map of MySQL server definitions (passwords read from Key Vault)
- var.mysql_databases — map of DBs referencing server keys
- env/dev/dev.tfvars and env/prod/prod.tfvars for environment-specific values

---

## Secrets & remote state
- Key Vault: data.azurerm_key_vault.kv_shared ("kv-digwi-shared") is read for:
  - vm_ssh_public_key
  - mysql_admin_password(s)
- Backend: Azure Storage Account container configured in backend.tf; pipelines override the backend `key` per environment
- Ensure service principal used by pipelines has:
  - Storage Blob Data Contributor (tfstate)
  - Key Vault Secrets User or appropriate RBAC
  - Contributor or scoped RBAC to deploy resources

---

## Pipelines (Azure DevOps)
- pipelines/azure-pipeline-pr.yml — PR validation (fmt, init, validate, plan)
- pipelines/azure-pipeline-dev.yml — Dev pipeline (plan & apply)
- pipelines/azure-pipeline-prod.yml — Prod plan + manual apply
- pipelines/pipeline-destroy.yml — Explicit destroy with confirmation

---

## Toggleable features & tips
- Enable Bastion: uncomment pip_bastion + bastion_host modules in main.tf (ensure AzureBastionSubnet is at least /26)
- PIPs: provisioned per-VM only when public_ip_enabled = true
- Hardening: restrict SSH in NSG rules to known IPs; add monitoring (Log Analytics), NSG flow logs
- Naming: verify global uniqueness for Key Vault & MySQL server names

---

## Where to look
- Root wiring: main.tf
- Variables: variables.tf
- Backend: backend.tf
- Env values: env/*/*.tfvars
- Modules: modules/*
- Pipelines: pipelines/*

---

## Next steps
- Add Terratest / automated infra tests
- Add conditional variables for enabling optional components
- Add monitoring, diagnostics, and automated secret rotation

---

Maintainer: update the contact and naming values to match your org standards.
```// filepath: c:\Users\digwi\OneDrive\Desktop\DevOps\Codesamples\Terraform Coding\infra-azure-cicd\README.md
<!-- ...existing code... -->
# infra-azure-cicd

Lightweight, production-minded Terraform layout to deploy a two‑tier app on Azure:
- Frontend → web VM(s)
- Backend → app VM(s)
- Data → MySQL Flexible Server in a dedicated data subnet
- Secure access → Azure Bastion (optional)
- Remote state → Azure Storage Account
- Secrets → Azure Key Vault
- Full networking: VNet, subnets, NICs, NSGs, PIPs, Private DNS for MySQL
- CI/CD ready (Azure DevOps pipelines included)

---

## Architecture (at a glance)
Simple logical diagram:

        Internet
           |
        Public IPs
      /    |     \
    Bastion  Web VM(s)  App VM(s)
      |        |           |
    AzureBastionSubnet  web subnet  app subnet
                         \          /
                          VNet
                           |
                       data subnet (MySQL Flexible Server)
                           |
                   privatelink.mysql.database.azure.com (Private DNS)

Key pieces:
- VNet with subnets: AzureBastionSubnet, web, app, data (delegated for MySQL)
- Per-VM NSG / NIC / (optional) Public IP
- Bastion host (commented by default; enable via modules)
- MySQL Flexible Server + DBs in delegated data subnet + Private DNS zone
- Key Vault used for SSH keys and DB passwords
- Storage Account used for Terraform remote state

---

## Highlights / Features
- Modular: modules for rg, vnet, snet, nsg, nic, pip, bastion, vm, mysql, private DNS
- Dynamic VM provisioning: var.vms map drives NIC, PIP, NSG and VM creation (for_each)
- Secure secret handling: data.azurerm_key_vault reads existing Key Vault secrets
- MySQL uses delegated subnet + privatelink for private connectivity
- CI/CD: PR validation, dev auto-apply, prod plan+apply pipelines included

---

## Quickstart (local)
1. Login & subscription
   - az login
   - az account set --subscription <id>
2. Initialize with remote backend
```bash
terraform init \
  -backend-config="resource_group_name=rg-digwi-terraform-remote" \
  -backend-config="storage_account_name=stgdigwiterraformstate" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=dev.terraform.tfstate"
```
3. Validate, plan, apply
```bash
terraform validate
terraform plan -var-file="env/dev/dev.tfvars" -out=tfplan
terraform apply -auto-approve tfplan
```

---