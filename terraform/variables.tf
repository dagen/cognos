# Define the variables we'll need for our project here.data

variable "os_username" {
    type = string
    default = "damon"
}

variable "region" {
    type = string
    default = "us-west-2"
}

variable "ssh_key_name" {
  type    = string
  default = "dagen"
}



