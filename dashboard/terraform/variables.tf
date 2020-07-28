variable ssh_key_name {
  description = "Name of the key-pair on EC2 (security-pem, aws-instance-access-pem, etc)"
}

variable vpc_id {
  description = "put your vpc id for the creation of the Security Group"
}

variable bucket_name {
  description = "put the bucketname here like 'cloudsnipper-bucket'"
}

variable subnet_id {
  description = "subnet for ec2"
}
