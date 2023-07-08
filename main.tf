resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = "${var.COMPONENT}-${var.ENV}"
  engine                  = "${var.ENGINE}"
  engine_version          = var.ENGINE_VERSION
  master_username         = jsondecode(data.aws_secretsmanager_secret_version.roboshop.secret_string)["RDS_USERNAME"]
  master_password         = jsondecode(data.aws_secretsmanager_secret_version.roboshop.secret_string)["RDS_PASSWORD"]
  skip_final_snapshot     = var.SKIP_FINAL_SNAPSHOT
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.example.name
  db_subnet_group_name = aws_docdb_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  availability_zones = [var.AZ]
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = var.NODE_COUNT
  identifier         = "${var.COMPONENT}-${var.ENV}-${count.index}"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = var.NODE_TYPE
}

data "aws_secretsmanager_secret" "roboshop" {
arn = "arn:aws:secretsmanager:us-east-1:697140473466:secret:roboshop-3wTSpx"
}

data "aws_secretsmanager_secret_version" "roboshop" {
secret_id = data.aws_secretsmanager_secret.roboshop.id
}
