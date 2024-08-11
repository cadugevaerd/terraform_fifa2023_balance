resource "aws_security_group" "ALB_Allow_Traffic" {
  name        = "allow_ecs_traffic"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "allow_ecs_traffic"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http_ALB" {
  security_group_id = aws_security_group.ALB_Allow_Traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "default_egress_ALB" {
  security_group_id = aws_security_group.ALB_Allow_Traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_security_group" "privateNetwork_Allow_Traffic" {
  name        = "allow_private_traffic"
  description = "Allow all private inbound traffic and all outbound traffic"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "allow_private_traffic"
  }
}

resource "aws_vpc_security_group_ingress_rule" "private_allow" {
  security_group_id = aws_security_group.privateNetwork_Allow_Traffic.id
  cidr_ipv4         = module.vpc.vpc_cidr_block
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "default_egress_private" {
  security_group_id = aws_security_group.privateNetwork_Allow_Traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}