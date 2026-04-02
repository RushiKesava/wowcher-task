# Common Infrastructure Variables
app_name        = "test-app"
vpc_name        = "test-vpc"
region          = "eu-west-2"

# You MUST replace this with the actual ARN of your ACM certificate for test.wowcher.co.uk
certificate_arn = "arn:aws:acm:eu-west-2:123456789012:certificate/REPLACE_WITH_ACTUAL_CERT_ARN"

# Subnet CIDRs as per requirements
private_subnet_cidrs = ["10.20.30.0/24", "10.20.31.0/24"]
public_subnet_cidrs  = ["10.20.32.0/24", "10.20.33.0/24"]
