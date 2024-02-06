# main.tf

provider "aws" {
  region = "us-east-1"  # Change to your desired AWS region
}

resource "aws_db_instance" "example_db" {
  identifier            = "example-db"
  allocated_storage     = 20
  engine                = "postgres"
  engine_version        = "13.4"
  instance_class        = "db.t2.micro"
  name                  = "example_db"
  username              = "admin"
  password              = "YourPasswordHere"  # Replace with your desired password
  publicly_accessible   = false

  provisioner "remote-exec" {
    inline = [
      "psql -h ${self.address} -U admin -d example_db -c 'CREATE TABLE IF NOT EXISTS users (id SERIAL PRIMARY KEY, name TEXT);'",
      "psql -h ${self.address} -U admin -d example_db -c 'INSERT INTO users (name) VALUES ('John');'",
      # Add additional setup commands as needed
    ]
  }
}
