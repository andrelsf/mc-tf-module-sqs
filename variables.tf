variable "environment" {
  description = "(Required) Define environment"
  type        = string
  nullable    = false
  default     = "dev"
  validation {
    condition     = contains(["dev", "hom", "prod"], var.environment)
    error_message = "Enviroment unsupported"
  }
}

variable "sqs_name" {
  description = "(Required) The name of the queue. Queue names must be made up of only uppercase and lowercase ASCII letters, numbers, underscores, and hyphens, and must be between 1 and 80 characters long."
  type        = string
  nullable    = false
  validation {
    condition     = length(var.sqs_name) >= 1 || length(var.sqs_name) <= 80
    error_message = "Invalid SQS Name"
  }
}

variable "fifo_queue" {
  description = "(Optional) Boolean designating a FIFO queue. If not set, it defaults to false making it standard."
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "(Optional) Enables content-based deduplication for FIFO queues."
  type        = bool
  default     = false
}

variable "deduplication_scope" {
  description = "value"
  type        = string
  default     = "queue"
  validation {
    condition     = contains(["messageGroup", "queue"], var.deduplication_scope)
    error_message = "Unsupported deduplication scope"
  }
}

variable "fifo_throughput_limit" {
  description = "(Optional) Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group. "
  type        = string
  default     = "perQueue"
  validation {
    condition     = contains(["perQueue", "perMessageGroupId"], var.fifo_throughput_limit)
    error_message = format("Unsupported value='%s' for fifo_throughput_limit", var.fifo_throughput_limit)
  }

}

variable "max_message_size" {
  description = "(Optional) The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB)."
  type        = number
  nullable    = false
  validation {
    condition     = var.max_message_size <= 262144
    error_message = "Invalid value for max message size"
  }
}

variable "message_retention_seconds" {
  description = "(Optional) The number of seconds Amazon SQS retains a message. Integer representing seconds. Default 4 days"
  type        = number
  nullable    = false
  validation {
    condition     = var.message_retention_seconds <= 1209600
    error_message = "Invalid value for message_retention_seconds. Max value is 1209600 (14 days)"
  }
}

variable "visibility_timeout_seconds" {
  description = "(Optional) The visibility timeout for the queue. An integer from 0 to 43200 (12 hours). Default 30"
  type        = number
  nullable    = false
  validation {
    condition     = var.visibility_timeout_seconds <= 43200
    error_message = "Invalid value for visibility_timeout_seconds. Max value is 43200 (12 hours)"
  }
}

variable "sqs_managed_sse_enabled" {
  description = "(Optional) Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys."
  type        = bool
  default     = false
}

variable "sse_kms_enabled" {
  description = "Enabled or disable SSE-KMS"
  type        = bool
  default     = false
}

variable "kms_master_key_id" {
  description = "(Optional) The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK."
  type        = string
  default     = null
}

variable "kms_data_key_reuse_period_seconds" {
  description = "(Optional) The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again.An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours). The default is 300 (5 minutes)"
  type        = number
  default     = 300
  nullable    = true
}

variable "delay_seconds" {
  description = " (Optional) The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes)."
  type        = number
  nullable    = false
  validation {
    condition     = var.delay_seconds >= 0 || var.delay_seconds <= 900
    error_message = "Invalid value for delay_seconds. Max value 900 (15 minutes)"
  }
}

variable "receive_wait_time_seconds" {
  description = "(Optional) The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds)."
  type        = number
  nullable    = false
  validation {
    condition     = var.receive_wait_time_seconds >= 0 || var.receive_wait_time_seconds <= 20
    error_message = "Invalid value for receive_wait_time_seconds. Max value is 20 (seconds)"
  }
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}