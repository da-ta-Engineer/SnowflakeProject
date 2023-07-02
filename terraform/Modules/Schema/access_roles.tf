# CREATE ACCESS ROLES

# READ-ONLY

resource "snowflake_role" "tr_sr" {
  name     = "TR_${var.ENV}_${var.database.name}_${var.schemaName}_SR"
  comment  = "${var.database.name} ${var.schemaName} READ-ONLY ACCESS ROLE"
}

# WRITE

resource "snowflake_role" "tr_srw" {
  name     = "TR_${var.ENV}_${var.database.name}_${var.schemaName}_SRW"
  comment  = "${var.database.name} ${var.schemaName} WRITE ACCESS ROLE"
}

# FULL

resource "snowflake_role" "tr_sfull" {
  name     = "TR_${var.ENV}_${var.database.name}_${var.schemaName}_SFULL"
  comment  = "${var.database.name} ${var.schemaName} FULL ACCESS ROLE"
}

# DEFINE LOCAL VARIABLES

locals {

  TR_ALL = [snowflake_role.tr_sr.name, snowflake_role.tr_srw.name, snowflake_role.tr_sfull.name]

  SR_TABLE_GRANTS     = ["SELECT"]
  SRW_TABLE_GRANTS    = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE"]
  SFULL_TABLE_GRANTS  = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE"]

  SFULL_SCHEMA_GRANTS = ["OWNERSHIP"]
}

# GRANT PRIVILEGES TO ACCESS ROLES

resource "snowflake_schema_grant" "stage_usage" {

  database_name     = var.database.name
  schema_name       = var.schemaName

  privilege         = "USAGE"
  roles             = local.TR_ALL

  with_grant_option = false
}

resource "snowflake_schema_grant" "stage_sfull" {

  for_each          = toset(local.SFULL_SCHEMA_GRANTS)
  database_name     = var.database.name
  schema_name       = var.schemaName

  privilege         = each.value
  roles             = [snowflake_role.tr_sfull.name]

with_grant_option = false
}

resource "snowflake_table_grant" "table_sr" {

  for_each          = toset(local.SR_TABLE_GRANTS)
  database_name     = var.database.name
  schema_name       = var.schemaName

  privilege         = each.value
  roles             = [snowflake_role.tr_sr.name]

  on_future         = true
  with_grant_option = false
}

resource "snowflake_table_grant" "table_srw" {

  for_each          = toset(local.SRW_TABLE_GRANTS)
  database_name     = var.database.name
  schema_name       = var.schemaName

  privilege         = each.value
  roles             = [snowflake_role.tr_srw.name]

  on_future         = true
  with_grant_option = false
}

resource "snowflake_table_grant" "table_sfull" {

  for_each          = toset(local.SFULL_TABLE_GRANTS)
  database_name     = var.database.name
  schema_name       = var.schemaName

  privilege         = each.value
  roles             = [snowflake_role.tr_sfull.name]

  on_future         = true
  with_grant_option = false
}

resource "snowflake_procedure_grant" "procedure_srw" {
  database_name     = var.database.name
  schema_name       = var.schemaName
  privilege         = "USAGE"
  roles             = [snowflake_role.tr_srw.name]

  on_future         = true
  with_grant_option = false
}

resource "snowflake_file_format_grant" "file_format_srw" {
  database_name     = var.database.name
  schema_name       = var.schemaName
  privilege         = "USAGE"
  roles             = [snowflake_role.tr_srw.name]

  on_future         = true
  with_grant_option = false
}

resource "snowflake_function_grant" "function_srw" {
  database_name     = var.database.name
  schema_name       = var.schemaName
  privilege         = "USAGE"
  roles             = [snowflake_role.tr_srw.name]

  on_future         = true
  with_grant_option = false
}



