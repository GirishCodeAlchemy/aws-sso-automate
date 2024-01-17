variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-2"
}

variable "build_number" {
  description = "Jenkins build number."
  default     = ""
}
