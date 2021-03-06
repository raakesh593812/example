locals {

  test_centralus_spoke_peering_data = {
    test1 = {
      target_vnet_rg               = "cus-networking-test1-rg"
      target_vnet_name             = "cus-networking-test1-vnet"
      addresesSpace                = "10.216.62.0/23"
      allow_virtual_network_access = true
      allow_forwarded_traffic      = true
      allow_gateway_transit        = true
      use_remote_gateways          = false      
      location                     = "centralus" 
    }

  }
  
  # azurerm provider used for hub and spoke peering
provider "azurerm" {  
  alias           = "spoke"
  subscription_id = var.az_sub_id_spoke
  tenant_id       = var.az_tenant_id
  client_id       = var.az_client_id_network
  client_secret   = var.az_client_secret_network
  features {}
}
  
  terraform {
  required_version = ">= 0.15.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.96.0"
    }
  }
}
  
  resource "azurerm_resource_group" "spokenetworking" {
  provider = azurerm.spoke

  for_each            = local.spoke_peering_data
  name                = each.value.target_vnet_rg
  location            = each.value.location  

}
  
  ####### Select Region Based locals #######
locals {
  locals_map_spoke = {
    "centralus" = {
      speer = local.test_centralus_spoke_peering_data   
      
    }
    "eastus2" = {
      speer = local.test_eastus2_spoke_peering_data
    }
  }
  spoke_peering_data = lookup(local.locals_map_spoke, var.location).speer  
}
