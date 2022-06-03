data "template_file" "mysql-userdata" {
 
  template = file("mysql-setup.tmpl")
  vars = {
    ROOT_PASSWORD     = var.root_password
    DATABASE_NAME     = var.database_name
    DATABASE_USER     = var.database_user
    DATABASE_PASSWORD = var.database_password
    DATABASE_HOST     = var.database_host
  }
}
data "template_file" "wordpress-userdata" {
 
  template = file("wordpress-setup.tmpl")
  vars = {
    DATABASE_NAME     = var.database_name
    DATABASE_USER     = var.database_user
    DATABASE_PASSWORD = var.database_password
    DATABASE_HOST     = aws_instance.dbserver.private_ip
  }
}

resource "aws_instance" "dbserver" {
  ami           = var.ami
  instance_type = var.instance_type
  associate_public_ip_address = true
  key_name = var.key_pair
  vpc_security_group_ids = [var.security_group]
  user_data_replace_on_change = true
  user_data = "${data.template_file.mysql-userdata.rendered}"

  tags = {
    Name = "dbserver"
  }
}


resource "aws_instance" "wordpress" {
  ami           = var.ami
  instance_type = var.instance_type
  associate_public_ip_address = true
  key_name = var.key_pair
  vpc_security_group_ids = [var.security_group]
  user_data_replace_on_change = true
  user_data = "${data.template_file.wordpress-userdata.rendered}"

  tags = {
    Name = "wordpress"
  }
}


output "mysql" {
    
  value = data.template_file.mysql-userdata.rendered
}
output "wordpress" {
    
  value = data.template_file.wordpress-userdata.rendered
}
output "dbserver-public-IP" {
    
    value = aws_instance.dbserver.private_ip
}
output "wordpress-public-IP" {
    
    value = aws_instance.wordpress.public_ip
}