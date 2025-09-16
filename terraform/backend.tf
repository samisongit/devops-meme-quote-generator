terraform {
  backend "s3" {
    bucket         = "sam-devops-project-tfstate" # Replace with your bucket name
    key            = "devops-meme-quote-generator/terraform.tfstate"
    region         = "us-east-2"                       # Replace with your region
    dynamodb_table = "devops-project-tfstate-lock"     # Replace with your table name
    encrypt        = true                              # Encrypt the state file in S3
  }
}