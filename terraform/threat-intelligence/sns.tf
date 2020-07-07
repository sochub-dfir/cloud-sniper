resource "aws_sns_topic" "cloud_sniper_sns_alarm" {
  for_each  = { "hub" = local.hub_account_id } == { "hub" = data.aws_caller_identity.current.account_id } ? { hub : true } : {}
  name = "cloud-sniper-sns-alarm"
}