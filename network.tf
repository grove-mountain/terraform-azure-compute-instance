resource "azurerm_virtual_network" "myfirstvn" {
    name                = "${var.name_prefix}-VN"
    address_space       = "${var.vn_address_space}"
    location            = "${var.vn_location}"
    resource_group_name = "${azurerm_resource_group.myfirstrg.name}"

    tags {
      environment = "${var.environment_tag}"
      ttl         = "${var.ttl_tag}"
      owner       = "${var.owner_tag}"
    }
}

resource "azurerm_subnet" "myfirstsubnet" {
    name                 = "${var.name_prefix}-Subnet"
    resource_group_name  = "${azurerm_resource_group.myfirstrg.name}"
    virtual_network_name = "${azurerm_virtual_network.myfirstvn.name}"
    address_prefix       = "${var.sb_address_prefix}"

}
