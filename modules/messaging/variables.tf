variable "account_project_name" {
  type = string
}

variable "nats" {
  type = list(object({
    name       = optional(string)
    region     = optional(string)
    account_id = optional(string)
  }))
  default = []
}

variable "sns" {
  type = list(object({
    region                      = optional(string)
    project_id                  = optional(string)
    name                        = optional(string)
    name_prefix                 = optional(string)
    content_based_deduplication = optional(bool)
    fifo_topic                  = optional(bool)
    protocol                    = optional(string)
    topic_arn                   = optional(string)
    topic_id                    = optional(string)
    redrive_policy              = optional(bool)
    sns_endpoint                = optional(string)
  }))
  default = []
}

variable "sqs" {
  type = list(object({
    region                      = optional(string)
    name                        = optional(string)
    name_prefix                 = optional(string)
    sqs_endpoint                = optional(string)
    fifo_queue                  = optional(bool)
    content_based_deduplication = optional(bool)
    receive_wait_time_seconds   = optional(number)
    visibility_timeout_seconds  = optional(number)
    message_max_age             = optional(number)
    message_max_size            = optional(number)
  }))
  default = []

  validation {
    condition     = ([for i in var.sqs : true if i.receive_wait_time_seconds > 0 || i.receive_wait_time_seconds < 20])
    error_message = "Values must be between 0 and 20."
  }

  validation {
    condition     = ([for j in var.sqs : true if j.visibility_timeout_seconds > 0 || j.visibility_timeout_seconds < 43200])
    error_message = "Values must be between 0 and 43200."
  }

  validation {
    condition     = ([for k in var.sqs : true if k.message_max_age > 60 || k.message_max_age < 1209600])
    error_message = "Values must be between 60 and 1209600."
  }

  validation {
    condition     = ([for l in var.sqs : true if l.message_max_size > 1024 || l.message_max_size < 262144])
    error_message = "Values must be between 1024 and 262144."
  }
}