variable "ami" {
    default = "ami-079b5e5b3971bd10d"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "key_pair" {
    default = "devops-morning"
}

variable "security_group" {
    default = "sg-045c61a479501c75e"
}

variable "root_password" {
  default = "mypassword"
}

variable "database_user" {
  default = "wpuser"
}

variable "database_name" {
  default = "wordpress"
}

variable "database_password" {
  default = "wppassword"
}


variable "database_host" {
  default = "%"
}
