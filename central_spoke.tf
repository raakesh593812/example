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
