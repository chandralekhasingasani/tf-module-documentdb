resource "null_resource" "test" {
  provisioner "local-exec" {
    command = <<EOF
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
cd /tmp
unzip mongodb.zip
cd mongodb-main
wget https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
mongo --ssl --host ${aws_docdb_cluster.docdb.endpoint}:27017 --sslCAFile global-bundle.pem --username ${data.aws_secretsmanager_secret_version.roboshop.secret_string["DOCUMENTDB_USERNAME"]} --password ${data.aws_secretsmanager_secret_version.roboshop.secret_string["DOCUMENTDB_PASSWORD"]}
mongo < ${var.DB_NAME}.js
EOF
  }
}