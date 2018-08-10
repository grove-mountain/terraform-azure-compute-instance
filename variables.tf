variable "student" {
  type        = "string"
  default     = "defaultStudent-20180619"
  description = "This variable defines the region resources will be created in"
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
    default     = "-1" 
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
