terraform {
  #backend "azurerm" {}
  required_providers {
    snowflake = {
      source  = "snowflake-labs/snowflake"
      version = "~> 0.57"
    }
  }
}

resource "snowflake_warehouse" "warehouse" {
  name                                = var.warehouseName
  warehouse_size                      = var.warehouseSize
  auto_suspend                        = var.autoSuspend
  initially_suspended                 = var.initiallySuspended
  enable_query_acceleration           = false
  query_acceleration_max_scale_factor = 0
}






