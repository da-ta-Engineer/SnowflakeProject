# CREATE ACCESS ROLES

# WU

resource "snowflake_role" "tr_wu" {
    name = "TR_${snowflake_warehouse.warehouse.name}_WU"
}

# WFULL

resource "snowflake_role" "tr_wfull" {
    name = "TR_${snowflake_warehouse.warehouse.name}_WFULL"
}

# DEFINE LOCAL VARIABLES

locals {

  WU_GRANTS           = ["USAGE", "MONITOR"]
  WFULL_GRANTS        = ["USAGE", "MONITOR", "MODIFY"]

}

# GRANT PRIVILEGES TO ACCESS ROLES

resource "snowflake_warehouse_grant" "usage" {
  warehouse_name = snowflake_warehouse.warehouse.name
  roles          = [snowflake_role.tr_wu.name, snowflake_role.tr_wfull.name]
  privilege      = "USAGE"
}

resource "snowflake_warehouse_grant" "monitor" {
  warehouse_name = snowflake_warehouse.warehouse.name
  roles          = [snowflake_role.tr_wu.name, snowflake_role.tr_wfull.name]
  privilege      = "MONITOR"
}

resource "snowflake_warehouse_grant" "modify" {
  warehouse_name = snowflake_warehouse.warehouse.name
  roles          = [snowflake_role.tr_wfull.name]
  privilege      = "MODIFY"
}