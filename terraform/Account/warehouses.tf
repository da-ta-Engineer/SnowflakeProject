// This module creates Snowflake warehouses. Warehouses are account-level objects and are not related with any particular database
// Warehouses are defined here with hardcoded names, where "DEV" stands for environment rather than specific database
// New warehouses can be added by creating new module block. Remember to add meaningful and unique Terraform ID

// Create warehouse WH_DEV_COMPUTE
//module "WH_DEV_COMPUTE" {
//  source                          = "../Modules/Warehouse/"
//  ENV                             = "DEV"
//  warehouseName                   = "WH_DEV_COMPUTE"
//  warehouseSize                   = "xsmall"
//  warehouseComment                = ""
//  autoSuspend                     = 60
//  initiallySuspended              = true
//}

//module "WH_QAS_COMPUTE" {
//  source                          = "../Modules/Warehouse/"
//  ENV                             = "QAS"
//  warehouseName                   = "WH_QAS_COMPUTE"
//  warehouseSize                   = "xsmall"
//  warehouseComment                = ""
//  autoSuspend                     = 60
//  initiallySuspended              = true
//}

//module "WH_PRD_COMPUTE" {
//  source                          = "../Modules/Warehouse/"
//  ENV                             = "PRD"
//  warehouseName                   = "WH_PRD_COMPUTE"
//  warehouseSize                   = "xsmall"
//  warehouseComment                = ""
//  autoSuspend                     = 60
//  initiallySuspended              = true
//}
