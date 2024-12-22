variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerVarName"
}

variable "nic_id" {
  description = "Value of the NIC used for this instance"
}