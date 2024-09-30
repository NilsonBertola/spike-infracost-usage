resource "aws_secretsmanager_secret" "db_password" {
  name        = "db_password"
  description = "RDS Postgres DB password"
}

resource "aws_secretsmanager_secret_version" "db_password_version" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = jsonencode({
    username = "dbuser"
    password = "supersecurepassword"  # Ideally use a randomly generated password
  })
}
