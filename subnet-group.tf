resource "aws_docdb_subnet_group" "default" {
  name       = "${var.COMPONENT}-${var.ENV}"
  subnet_ids = var.SUBNET_IDS

  tags = {
    Name = "${var.COMPONENT}-${var.ENV}"
  }
}