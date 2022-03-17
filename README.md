<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Description

Provisions a guard duty detector and sets up a subscription

## Usage

After deploying the [Report Receiver](https://github.com/dod-iac/terraform-aws-report-receiver) in the receiving account, use the output role and kinesis from that module with this

Resources:

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_guardduty_detector.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_detector) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deploy_detector"></a> [deploy\_detector](#input\_deploy\_detector) | Determines if Guard Duty Detector is deployed as part of configuration or not | `bool` | `true` | no |
| <a name="input_kinesis_stream_arn"></a> [kinesis\_stream\_arn](#input\_kinesis\_stream\_arn) | ARN of the kinesis stream that is published to. This should be provided by the receiving account | `string` | n/a | yes |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | ARN of the role to be assumed in receiving account | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to the AWS resources. | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
