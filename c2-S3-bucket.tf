# Provider Block
provider "aws" {
  region  = "eu-central-1"
}

#Resource block
resource "aws_s3_bucket" "demo-static-site-99887" {
  bucket = "demo-static-site-99887"
  acl = "public-read"
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

#To add Index.html
resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.demo-static-site-99887.id
  key    = "index.html"
  source = "index.html"
  content_type = "text/html"
}

#To add Error.html
resource "aws_s3_bucket_object" "error" {
  bucket = aws_s3_bucket.demo-static-site-99887.id
  key    = "error.html"
  source = "error.html"
  content_type = "text/html"
}

#Bucket policy so that it's accessible from internet
resource "aws_s3_bucket_policy" "demo-static-site-99887" {
  bucket = aws_s3_bucket.demo-static-site-99887.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.demo-static-site-99887.bucket}/*"
    }
  ]
}
EOF
}