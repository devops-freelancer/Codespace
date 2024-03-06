
data "aws_iam_policy_document" "s3-bucket-policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [ aws_iam_role.source-lambda-role.arn ]
    }
    effect    = "Allow"
    actions   = [
        "s3:GetObject",
        "s3:GetBucketLocation",
        "s3:AbortMultipatUploads",
        "s3:PutObject",
        "s3:PutObjectAcl",
        "s3:ListBucket",
        "s3:ListBucketMultipatUploads"   
        ]
    resources = ["arn:aws:s3:::${var.bucket-name}/*"]
  }

  }

module "s3-bucket" {
  source             = "terraform-aws-modules/s3-bucket/aws"
  version            = "4.1.0"  
  bucket             = var.bucket-name
  tags               = var.tags
  policy             = true 
  providers          =  aws.cross-account
  block_public_acls  = true
  block_public_policy      = true
  ignore_public_acls       = true
  restrict_public_buckets  = true
  attach_policy            = data.aws_iam_policy_document.s3-bucket-policy.json       
}

