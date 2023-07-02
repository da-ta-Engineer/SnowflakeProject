// This module creates Snowflake schemas for each database specified in the local variable 'databases'.

// Following set of modules is used for the main databases
// If you want to add new database with different set of schemas, then go to databases.tf, define new database and new database group in "locals" 
// After that you can add here new modules with required schemas, remember to change for_each parameter to your new database group

// Create a schema for the 'STAGE' schema in each database
module "schema_stage" {
  for_each            = local.databases      // loop over the databases specified in the local variable
  source              = "../Modules/Schema/" // set the path to the schema module
  ENV                 = each.value["env"]    // set the environment for the schema module
  database            = each.value["name"]   // set the database for the schema module
  schemaName          = "STAGE"              // set the name for the 'STAGE' schema
  schemaComment       = "Raw data storage"   // set an optional comment for the schema
  schemaIsTransient   = false                // set whether the schema is transient or not
  schemaIsManaged     = true                 // set whether the schema is managed or not
  dataRetentionDays   = 1                    // set the data retention time for the schema
}

module "schema_core" {
  for_each            = local.databases      
  source              = "../Modules/Schema/" 
  ENV                 = each.value["env"]    
  database            = each.value["name"]   
  schemaName          = "CORE"            
  schemaComment       = "Transformed data storage"                   
  schemaIsTransient   = false                
  schemaIsManaged     = true                 
  dataRetentionDays   = 1                    
}

module "schema_access" {
  for_each            = local.databases      
  source              = "../Modules/Schema/" 
  ENV                 = each.value["env"]    
  database            = each.value["name"]   
  schemaName          = "ACCESS"            
  schemaComment       = "Transformed and aggegated view layer"                   
  schemaIsTransient   = false                
  schemaIsManaged     = true                 
  dataRetentionDays   = 1                    
}

module "schema_metadata" {
  for_each            = local.databases      
  source              = "../Modules/Schema/" 
  ENV                 = each.value["env"]    
  database            = each.value["name"]   
  schemaName          = "METADATA"            
  schemaComment       = "Metadata storage for backend processes"                   
  schemaIsTransient   = false                
  schemaIsManaged     = true                 
  dataRetentionDays   = 1                    
}