variable "deploy_detector" {
  type        = bool
  default     = true
  description = "Determines if Guard Duty Detector is deployed as part of configuration or not"
}
variable "kinesis_stream_arn" {
  type        = string
  description = "ARN of the kinesis stream that is published to. This should be provided by the receiving account"
}
variable "role_arn" {
  type        = string
  description = "ARN of the role to be assumed in receiving account"
}
variable "tags" {
  type        = map(string)
  description = "Tags applied to the AWS resources."
  default     = {}

}