location    = "eastus"
environment = "dev"

hub_vnet_address_space   = ["10.0.0.0/16"]
spoke_vnet_address_space = ["10.1.0.0/16"]

tags = {
  Environment = "dev"
  Project     = "LandingZone"
  ManagedBy   = "Terraform"
}
