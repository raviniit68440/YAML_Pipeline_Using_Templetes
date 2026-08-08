location    = "eastus"
environment = "uat"

hub_vnet_address_space   = ["10.10.0.0/16"]
spoke_vnet_address_space = ["10.11.0.0/16"]

tags = {
  Environment = "uat"
  Project     = "LandingZone"
  ManagedBy   = "Terraform"
}
