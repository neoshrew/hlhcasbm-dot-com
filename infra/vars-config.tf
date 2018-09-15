provider aws {
  region = "${var.aws_region}"
}

provider aws {
  alias  = "global"
  region = "us-east-1"
}

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
