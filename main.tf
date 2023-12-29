#
# SQS Queue
#
resource "aws_sqs_queue" "sqs_queue" {
  name                              = var.fifo_queue ? "${var.sqs_name}.fifo" : var.sqs_name
  fifo_queue                        = var.fifo_queue
  content_based_deduplication       = var.content_based_deduplication
  delay_seconds                     = var.delay_seconds
  max_message_size                  = var.max_message_size
  message_retention_seconds         = var.message_retention_seconds
  receive_wait_time_seconds         = var.receive_wait_time_seconds
  visibility_timeout_seconds        = var.visibility_timeout_seconds
  sqs_managed_sse_enabled           = var.sqs_managed_sse_enabled
  kms_master_key_id                 = var.sse_kms_enabled ? var.kms_master_key_id : null
  kms_data_key_reuse_period_seconds = var.sse_kms_enabled ? var.kms_data_key_reuse_period_seconds : null
}
