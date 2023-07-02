terraform {
  #backend "azurerm" {}
  required_providers {
    snowflake = {
      source  = "snowflake-labs/snowflake"
      version = "~> 0.57"
    }
  }
}

resource "snowflake_schema" "schema" {
  database            = var.database.name
  name                = var.schemaName
  comment             = var.schemaComment
  is_transient        = var.schemaIsTransient
  is_managed          = var.schemaIsManaged
  data_retention_days = var.dataRetentionDays
  
}



