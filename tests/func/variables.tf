variable "project_code" {
  type        = string
  description = "The name of the project for func01 eg. pla"
}

variable "service_code" {
  type        = string
  description = "The name of the service code for func01 eg. whlst01"
}

variable "environment_short" {
  type        = string
  description = "The short name of the environment for func01 eg. dev, prod, test"
}

variable "location" {
  type        = string
  description = "The location of the resource group for func01 eg. westeurope"
}

variable "os_type" {
  type        = string
  description = "The operating system type for func01 eg. Linux, Windows"
  default     = "Linux"
}

variable "sku_name" {
  type        = string
  description = "The sku name for func01 eg. Y1, Y2, Y3"
  default     = "Y1"
}

variable "account_tier" {
  type        = string
  description = "The account tier for func01 eg. Standard, Premium"
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "The account replication type for func01 eg. LRS, GRS, RAGRS, ZRS"
  default     = "LRS"
}

variable "tags" {
  type        = map(string)
  description = "The tags for func01 eg. { env = `dev`, project = `name`, service = `name` }"
  default     = {}
}
