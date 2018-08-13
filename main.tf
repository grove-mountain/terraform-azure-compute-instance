# Create a resource group if it doesn’t exist
resource "azurerm_resource_group" "myfirstrg" {
  name     = "${var.name_prefix}-RG"
  location = "${var.resource_group_location}"

  tags {
    environment = "${var.environment_tag}"
    ttl         = "${var.ttl_tag}"
    owner       = "${var.owner_tag}"
  }
}

module "windowsserver" {
  source              = "Azure/compute/azurerm"
  version             = "1.1.6"
  location            = "${var.resource_group_location}"
  vm_hostname         = "windowsvm"
  vm_size             = "${var.vm_size}"
  admin_password      = "${var.admin_password}"
  vm_os_simple        = "WindowsServer"
  public_ip_dns       = ["${var.name_prefix}"]
  vnet_subnet_id      = "${azurerm_subnet.myfirstsubnet.id}"
  resource_group_name = "${azurerm_resource_group.myfirstrg.name}"
}
