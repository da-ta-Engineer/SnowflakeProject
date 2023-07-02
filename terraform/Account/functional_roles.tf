// DEFINE LOCAL VARIABLES, THEY ARE USED TO GROUP ACCESS ROLES WITH THE SAME PRIVILEGES
// E.G. IF YOU WANT TO GRANT READ ACCESS ON ALL SCHEMAS IN DEV DATABASE YOU CAN USE DEV_READ GROUP

locals {
  DEV_READ  = [module.schema_stage["dev"].read.name, 
               module.schema_core["dev"].read.name, 
               module.schema_access["dev"].read.name]
              
  QAS_READ  = [module.schema_stage["qas"].read.name, 
               module.schema_core["qas"].read.name, 
               module.schema_access["qas"].read.name]
              
  PRD_READ  = [module.schema_stage["prd"].read.name, 
               module.schema_core["prd"].read.name, 
               module.schema_access["prd"].read.name]

  DEV_WRITE = [module.schema_stage["dev"].write.name, 
               module.schema_core["dev"].write.name, 
               module.schema_access["dev"].write.name]
              
  QAS_WRITE = [module.schema_stage["qas"].write.name, 
               module.schema_core["qas"].write.name, 
               module.schema_access["qas"].write.name]
              
  PRD_WRITE = [module.schema_stage["prd"].write.name, 
               module.schema_core["prd"].write.name, 
               module.schema_access["prd"].write.name]

  DEV_FULL  = [module.schema_stage["dev"].full.name, 
               module.schema_core["dev"].full.name, 
               module.schema_access["dev"].full.name]
              
  QAS_FULL  = [module.schema_stage["qas"].full.name, 
               module.schema_core["qas"].full.name, 
               module.schema_access["qas"].full.name]
              
  PRD_FULL  = [module.schema_stage["prd"].full.name, 
               module.schema_core["prd"].full.name, 
               module.schema_access["prd"].full.name]
}

# GRANT DATABASE USAGE TO ACCESS ROLES

resource "snowflake_database_grant" "dev_db_usage" {

  database_name     = snowflake_database.dev.name

  privilege         = "USAGE"
  roles             = concat(local.DEV_READ, local.DEV_WRITE, local.DEV_FULL)

  with_grant_option = false
}

resource "snowflake_database_grant" "qas_db_usage" {

  database_name     = snowflake_database.qas.name

  privilege         = "USAGE"
  roles             = concat(local.QAS_READ, local.QAS_WRITE, local.QAS_FULL)

  with_grant_option = false
}

resource "snowflake_database_grant" "prd_db_usage" {

  database_name     = snowflake_database.prd.name

  privilege         = "USAGE"
  roles             = concat(local.PRD_READ, local.PRD_WRITE, local.PRD_FULL)

  with_grant_option = false
}

# CREATE FUNCTIONAL ROLES
# FIRST DEFINE YOUR NEW ROLE

resource "snowflake_role" "schemachange" {
    name    = "FR_SCHEMACHANGE"
    comment = "FUNCTIONAL ROLE WITH FULL ACCESS TO ALL SCHEMAS. USED BY SCHEMACHANGE TECHNICAL-USER ONLY."
}

resource "snowflake_role" "developer" {
    name    = "FR_DEVELOPER"
    comment = "FUNCTIONAL ROLE WITH FULL ACCESS TO ALL SCHEMAS IS DEV AND QA."
}

resource "snowflake_role" "viewer" {
    name    = "FR_VIEWER"
    comment = "FUNCTIONAL ROLE WITH READ ACCESS TO QA AND PRD."
}

resource "snowflake_role" "etl_dev" {
    name    = "FR_ETL_DEV"
    comment = "FUNCTIONAL ROLE WITH WRITE ACCESS TO DEV."
}

resource "snowflake_role" "etl_qas" {
    name    = "FR_ETL_QAS"
    comment = "FUNCTIONAL ROLE WITH WRITE ACCESS TO QAS."
}

resource "snowflake_role" "etl_prd" {
    name    = "FR_ETL_PRD"
    comment = "FUNCTIONAL ROLE WITH WRITE ACCESS TO PRD."
}

# FUNCTIONAL GRANTS
# NOW GRANT ACCESS ROLES TO YOUR NEW ROLE. 
# YOU CAN CHOOSE DIFFERENT PRIVILEGE SCOPE FOR EACH ENVIRONMENT.

resource "snowflake_role_grants" "schemachange_grant" {
    for_each  = toset(concat(local.DEV_FULL, local.QAS_FULL, local.PRD_FULL))
    role_name = each.value
    roles     = [snowflake_role.schemachange.name]
}

resource "snowflake_role_grants" "developer_grant" {
    for_each  = toset(concat(local.DEV_FULL, local.QAS_FULL))
    role_name = each.value         
    roles     = [snowflake_role.developer.name]
}

resource "snowflake_role_grants" "viewer_grant" {
    for_each  = toset(concat(local.QAS_READ, local.PRD_READ))
    role_name = each.value         
    roles     = [snowflake_role.viewer.name]
}

resource "snowflake_role_grants" "etl_dev_grant" {
    for_each  = toset(local.DEV_WRITE)
    role_name = each.value
    roles     = [snowflake_role.etl_dev.name]
}

resource "snowflake_role_grants" "etl_qas_grant" {
    for_each  = toset(local.QAS_WRITE)
    role_name = each.value
    roles     = [snowflake_role.etl_qas.name]
}

resource "snowflake_role_grants" "etl_prd_grant" {
    for_each  = toset(local.PRD_WRITE)
    role_name = each.value
    roles     = [snowflake_role.etl_prd.name]
}

# ADDITIONALLY GRANT DATABASE CREATE PRIVILEGE TO SCHEMACHANGE ROLE TO ENABLE CLONING

resource "snowflake_account_grant" "create_database_grant" {
    roles             = [snowflake_role.schemachange.name]  
    privilege         = "CREATE DATABASE"
    with_grant_option = false
}

# GRANT FUNCTIONAL ROLES TO SYSADMIN

resource "snowflake_role_grants" "fr_sysadmin_grants" {
    for_each = toset([snowflake_role.schemachange.name,
                      snowflake_role.developer.name,
                      snowflake_role.viewer.name,
                      snowflake_role.etl_dev.name,
                      snowflake_role.etl_qas.name,
                      snowflake_role.etl_prd.name])
    role_name = each.value
    roles     = ["SYSADMIN"]
}
