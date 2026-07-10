# S3 Remote State Backend Configuration
#
# SETUP INSTRUCTIONS:
# 1. On first run, initialize Terraform WITHOUT this backend enabled:
#    terraform init
#
# 2. Apply the infrastructure to create S3 bucket and other resources:
#    terraform apply
#
# 3. Create an S3 bucket for state management (outside Terraform or manually):
#    - Bucket name should follow pattern: terraform-state-{project}-{environment}-{account-id}
#    - Enable versioning on the bucket
#    - Enable server-side encryption
#    - Block all public access
#
# 4. After state bucket is created, uncomment the backend block below:
#    terraform init -migrate-state
#
# 5. Confirm migration when prompted to move state to S3

# terraform {
#   backend "s3" {
#     bucket         = "terraform-state-portfolio-site-production-{account-id}"
#     key            = "portfolio-site/terraform.tfstate"
#     region         = "ap-south-1"
#     encrypt        = true
#     dynamodb_table = "terraform-locks"
#   }
# }
