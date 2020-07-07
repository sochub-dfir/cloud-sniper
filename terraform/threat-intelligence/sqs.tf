resource "aws_sqs_queue" "cloud_sniper_sqs_queue_threat_intelligence_automation" {
  for_each = { "hub" = local.hub_account_id } == { "hub" = data.aws_caller_identity.current.account_id } ? { hub : true } : {}
  name     = "cloud-sniper-sqs-queue-threat-intelligence-automation"

  tags = local.cloud_sniper_tags
}

resource "aws_sqs_queue_policy" "cloud_sniper_sqs_queue_policy_security_ir" {
  for_each  = { "hub" = local.hub_account_id } == { "hub" = data.aws_caller_identity.current.account_id } ? { hub : true } : {}
  queue_url = aws_sqs_queue.cloud_sniper_sqs_queue_threat_intelligence_automation["hub"].id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.cloud_sniper_sqs_queue_threat_intelligence_automation["hub"].arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_cloudwatch_event_rule.cloud_sniper_cloudwatch_event_rule_threat_intelligence_automation["hub"].arn}"
        }
      }
    }
  ]
}
POLICY
}