variable "instancetype" {
  type        = string
  description = "set aws instance type"
  default     = "t2.micro"
}

variable "aws_common_tag" {
  type        = map(string)
  description = "set aws tag"
  default = {
    Name = "ec2-eazytraning"
  }
}