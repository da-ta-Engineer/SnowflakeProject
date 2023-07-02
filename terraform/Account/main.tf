terraform {
  required_providers {
    snowflake = {
      source  = "snowflake-labs/snowflake"
      version = "~> 0.57"
    }
  }
}

provider "snowflake" {
}