// Creates a Snowflake database DEV
resource "snowflake_database" "dev" {
  name                        = "DEV"                      // sets the name of the database
  comment                     = ""                         // sets a comment for the database
  data_retention_time_in_days = 1                          // sets the time to retain data in days
  is_transient                = false                      // sets whether the database is transient or persistent
}

// Creates a Snowflake database QAS
resource "snowflake_database" "qas" {
  name                        = "QAS" 
  comment                     = "" 
  data_retention_time_in_days = 1 
  is_transient                = false 
}

// Creates a Snowflake database PRD
resource "snowflake_database" "prd" {
  name                        = "PRD" 
  comment                     = "" 
  data_retention_time_in_days = 1 
  is_transient                = false 
}

// Defines a local variable to store a map of database resources and their environment. 
// It will be used in the schema module to create schemas and roles for each of those databases. 

locals {
  databases = {
    "dev": {
      "name": snowflake_database.dev,                    // sets the resource for the dev database
      "env": "DEV"                                       // sets the environment name for the dev database
    },
    "qas": {
      "name": snowflake_database.qas, 
      "env": "QAS" 
    },
    "prd": {
      "name": snowflake_database.prd, 
      "env": "PRD" 
    }
  }
}
