locals {
  name_prefix = "lz-${var.environment}"
}

# --- Resource Groups ---
module "rg_hub" {
  source   = "../../modules/resource_group"
  name     = "rg-${local.name_prefix}-hub-eastasia"
  location = var.location
  tags     = var.tags
}

module "rg_spoke" {
  source   = "../../modules/resource_group"
  name     = "rg-${local.name_prefix}-spoke-eastasia"
  location = var.location
  tags     = var.tags
}

# --- Virtual Networks ---
module "hub_vnet" {
  source              = "../../modules/virtual_network"
  name                = "vnet-${local.name_prefix}-hub"
  location            = var.location
  resource_group_name = module.rg_hub.name
  address_space       = var.hub_vnet_address_space
  tags                = var.tags
}

module "spoke_vnet" {
  source              = "../../modules/virtual_network"
  name                = "vnet-${local.name_prefix}-spoke"
  location            = var.location
  resource_group_name = module.rg_spoke.name
  address_space       = var.spoke_vnet_address_space
  tags                = var.tags
}

# --- Subnets ---
module "hub_bastion_subnet" {
  source               = "../../modules/subnet"
  name                 = "AzureBastionSubnet"
  resource_group_name  = module.rg_hub.name
  virtual_network_name = module.hub_vnet.name
  address_prefixes     = [cidrsubnet(var.hub_vnet_address_space[0], 10, 1)] # /26
}

module "spoke_web_subnet" {
  source               = "../../modules/subnet"
  name                 = "snet-web"
  resource_group_name  = module.rg_spoke.name
  virtual_network_name = module.spoke_vnet.name
  address_prefixes     = [cidrsubnet(var.spoke_vnet_address_space[0], 8, 1)] # /24
}

module "spoke_app_subnet" {
  source               = "../../modules/subnet"
  name                 = "snet-app"
  resource_group_name  = module.rg_spoke.name
  virtual_network_name = module.spoke_vnet.name
  address_prefixes     = [cidrsubnet(var.spoke_vnet_address_space[0], 8, 2)] # /24
}

# --- NSGs & Route Tables ---
module "nsg_web" {
  source              = "../../modules/nsg"
  name                = "nsg-web-${local.name_prefix}"
  location            = var.location
  resource_group_name = module.rg_spoke.name
  subnet_id           = module.spoke_web_subnet.id
  tags                = var.tags
}

module "rt_spoke" {
  source              = "../../modules/route_table"
  name                = "rt-spoke-${local.name_prefix}"
  location            = var.location
  resource_group_name = module.rg_spoke.name
  subnet_id           = module.spoke_web_subnet.id
  tags                = var.tags
}

# --- VNet Peering ---
module "peering_hub_to_spoke" {
  source                    = "../../modules/vnet_peering"
  name                      = "peer-hub-to-spoke"
  resource_group_name       = module.rg_hub.name
  virtual_network_name      = module.hub_vnet.name
  remote_virtual_network_id = module.spoke_vnet.id
}

module "peering_spoke_to_hub" {
  source                    = "../../modules/vnet_peering"
  name                      = "peer-spoke-to-hub"
  resource_group_name       = module.rg_spoke.name
  virtual_network_name      = module.spoke_vnet.name
  remote_virtual_network_id = module.hub_vnet.id
}

# --- Private DNS ---
module "private_dns" {
  source              = "../../modules/private_dns"
  name                = "privatelink.database.windows.net"
  resource_group_name = module.rg_hub.name
  virtual_network_id  = module.hub_vnet.id
  tags                = var.tags
}

# Security & Identity Modules Removed

# --- Monitoring ---
module "law" {
  source              = "../../modules/log_analytics"
  name                = "law-${local.name_prefix}"
  location            = var.location
  resource_group_name = module.rg_hub.name
  tags                = var.tags
}

module "monitor_ag" {
  source                 = "../../modules/azure_monitor"
  action_group_name      = "ag-${local.name_prefix}"
  short_name             = "aglz"
  resource_group_name    = module.rg_hub.name
  email_receiver_name    = "Admin"
  email_receiver_address = "admin@example.com"
  tags                   = var.tags
}

# KV diagnostic settings removed

# --- Backup ---
module "rsv" {
  source              = "../../modules/recovery_services_vault"
  name                = "rsv-${local.name_prefix}"
  location            = var.location
  resource_group_name = module.rg_hub.name
  tags                = var.tags
}

module "backup_policy_vm" {
  source              = "../../modules/vm_backup_policy"
  name                = "policy-daily-vm"
  resource_group_name = module.rg_hub.name
  recovery_vault_name = module.rsv.name
}

# --- Workload & Secure Access ---

module "hub_appgw_subnet" {
  source               = "../../modules/subnet"
  name                 = "snet-appgw"
  resource_group_name  = module.rg_hub.name
  virtual_network_name = module.hub_vnet.name
  address_prefixes     = [cidrsubnet(var.hub_vnet_address_space[0], 8, 2)] # /24
}

module "bastion" {
  source              = "../../modules/bastion"
  name                = "bas-${local.name_prefix}"
  location            = var.location
  resource_group_name = module.rg_hub.name
  subnet_id           = module.hub_bastion_subnet.id
  tags                = var.tags
}

module "app_gateway" {
  source              = "../../modules/application_gateway"
  name                = "agw-${local.name_prefix}"
  location            = var.location
  resource_group_name = module.rg_hub.name
  subnet_id           = module.hub_appgw_subnet.id
  tags                = var.tags
}

# Hardcoded password per user request
module "linux_vm" {
  source                             = "../../modules/linux_vm"
  name                               = "vm-lin-${local.name_prefix}"
  location                           = var.location
  resource_group_name                = module.rg_spoke.name
  subnet_id                          = module.spoke_web_subnet.id
  admin_username                     = "azureadmin"
  admin_password                     = "AzureAdminP@ssw0rd123!"
  app_gateway_backend_pool_id        = module.app_gateway.backend_address_pool_id
  recovery_vault_name                = module.rsv.name
  recovery_vault_resource_group_name = module.rg_hub.name
  backup_policy_id                   = module.backup_policy_vm.id
  tags                               = var.tags
}

module "windows_vm" {
  source                             = "../../modules/windows_vm"
  name                               = "vm-win-${var.environment}"
  location                           = var.location
  resource_group_name                = module.rg_spoke.name
  subnet_id                          = module.spoke_web_subnet.id
  admin_username                     = "azureadmin"
  admin_password                     = "AzureAdminP@ssw0rd123!"
  app_gateway_backend_pool_id        = module.app_gateway.backend_address_pool_id
  recovery_vault_name                = module.rsv.name
  recovery_vault_resource_group_name = module.rg_hub.name
  backup_policy_id                   = module.backup_policy_vm.id
  tags                               = var.tags
}
