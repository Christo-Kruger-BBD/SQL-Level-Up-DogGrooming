
data "aws_secretsmanager_secret_version" "creds" {
  # write your secret name here
  secret_id = "dbcreds"
}