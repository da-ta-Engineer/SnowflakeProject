variable "ENV" {
  type = string
  description = "Environment name: dev/qas/prd"
}

variable "warehouseName" {
  type = string
}

variable "warehouseSize" {
  type = string
}

variable "warehouseComment" {
  type = string
}

variable "autoSuspend" {
  type = number
}

variable "initiallySuspended" {
  type = bool
}