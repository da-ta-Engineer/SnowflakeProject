variable "ENV" {
  type = string
  description = "Environment name: dev/qas/prd"
}

variable "database" {
  type = object({
    name                        = string
    comment                     = string
    data_retention_time_in_days = number
    is_transient                = bool
  })
}

variable "schemaName" {
  type = string
}

variable "schemaComment" {
  type = string
}

variable "schemaIsTransient" {
  type = bool
}

variable "schemaIsManaged" {
  type = bool
}

variable "dataRetentionDays" {
  type = number
}