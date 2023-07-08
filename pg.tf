resource "aws_docdb_cluster_parameter_group" "example" {
  family      = "${var.FAMILY}"
  name        = "${var.COMPONENT}-${var.ENV}"
  description = "docdb cluster parameter group"
}