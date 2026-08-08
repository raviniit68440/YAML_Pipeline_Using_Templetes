location    = "eastus"
environment = "prod"

hub_vnet_address_space   = ["10.20.0.0/16"]
spoke_vnet_address_space = ["10.21.0.0/16"]

tags = {
  Environment = "prod"
  Project     = "LandingZone"
  ManagedBy   = "Terraform"
}
