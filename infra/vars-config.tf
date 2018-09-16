provider aws {
  region              = "${var.aws_region}"
  allowed_account_ids = ["${var.aws_account_id}"]
}

provider aws {
  alias               = "global"
  region              = "us-east-1"
  allowed_account_ids = ["${var.aws_account_id}"]
}

variable aws_account_id {}

variable global_prefix {
  description = "Global prefix to distinguish from other things"
  default     = "apgelnar"
}

variable prefix {
  description = "Prefix to tell you what this is"
  default     = "hlhcasbm"
}

variable aws_region {
  description = "Which aws region to put stuff in"
  default = "eu-west-2" # London baby, yeah.
}

variable log_expiration_days {
  default = 30
}

variable site_domain {
  default = "howlonghavechrisandsofijabeenmarried.com"
}

variable route53_zone_name {
  default = "howlonghavechrisandsofijabeenmarried.com"
}

variable cf_price_class {
  default = "PriceClass_100"
}
