variable "name_prefix" {
  type        = "string"
  default     = "deleteMeNow"
  description = "The name prepended to any resources created.  These should be unique between environments as Resource Groups are used here.   e.g. jlundberg-dev, jlundberg-qa, jlundberg-prod"
}

variable "resource_group_location" {
    type        = "string"
    default     = "East US"
    description = "This variable defines the region resources will be created in"
}
variable "environment_tag" { 
    type        = "string" 
    default     = "Production" 
    description = "Environment Tag"
}

variable "ttl_tag" { 
    type        = "string" 
    default     = "24" 
    description = "Time To Live in hours for tagged resources.  Do not use units.  -1 is infinite"
}

variable "owner_tag" { 
    type        = "string" 
    default     = "ops@" 
    description = "Owner of resources created."
}

variable "vn_address_space" {
    type        = "list"
    default     = ["10.0.0.0/16"]
    description = "This is the default open network"
}

variable "vn_location" {
    type        = "string"
    default     = "East US"
    description = "This variable defines the virtual network location"
}

variable "sb_address_prefix" {
    type        = "string"
    default     = "10.0.1.0/24"
    description = "Subnet CIDR"
}

variable "admin_password" {
    type        = "string"
    default     = "8675309-Jenny"
    description = "Admin password for windows servers created"
}

variable "vm_size" {
    type        = "string"
    default     = "Standard_DS1_V2"
    description = "Virtual Machine instance type"
}

