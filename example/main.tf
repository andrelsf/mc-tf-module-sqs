module "sqs_queue" {
  source                      = "git::https://github.com/andrelsf/mc-module-tf-sqs.git?ref=1.0.0"
  sqs_name                    = "payments-queue"
  fifo_queue                  = true
  content_based_deduplication = true
  sqs_managed_sse_enabled     = true
  max_message_size            = 262144
  message_retention_seconds   = 86400
  visibility_timeout_seconds  = 30
  delay_seconds               = 0
  receive_wait_time_seconds   = 10
}