# Default to Sydney; override aws_region when deploying to another AWS region.
variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "ap-southeast-2"
}
