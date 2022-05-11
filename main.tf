/**
 *
 * ## Description
 *
 * Provisions a guard duty detector and sets up a subscription
 *
 * ## Usage
 *
 * After deploying the [Report Receiver](https://github.com/dod-iac/terraform-aws-report-receiver) in the receiving account, use the output role and kinesis from that module with this
 *
 * Resources:
 *
 *
  ```hcl
    module "guardduty_stream" {
    source                = "../../modules/kinesiss-stream-config"
    source_account        = data.aws_caller_identity.current.id
    security_group_ids    = [module.elmo.es_ingress_sg]
    subnet_ids            = module.elmo.private_subnet_ids
    opensearch_domain_arn = module.elmo.es_domain
    stream_type           = "guardduty"
    error_logging_bucket  = module.elmo.logging_bucket
    }
    module "guardduty" {
    source             = "../../modules/guard-duty-deployment"
    role_arn           = module.guardduty_stream.publish_role_arn
    kinesis_stream_arn = module.guardduty_stream.kinesis_stream_arn
    }
```
 *
 * ## Testing
 *
 * Run all terratest tests using the `terratest` script.  If using `aws-vault`, you could use `aws-vault exec $AWS_PROFILE -- terratest`.  The `AWS_DEFAULT_REGION` environment variable is required by the tests.  Use `TT_SKIP_DESTROY=1` to not destroy the infrastructure created during the tests.  Use `TT_VERBOSE=1` to log all tests as they are run.  Use `TT_TIMEOUT` to set the timeout for the tests, with the value being in the Go format, e.g., 15m.  The go test command can be executed directly, too.
 *
 * ## Terraform Version
 *
 * Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.
 *
 * Terraform 0.11 and 0.12 are not supported.
 *
 * ## License
 *
 * This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.
 *
 * ## Developer Setup
 *
 * This template is configured to use aws-vault, direnv, go, pre-commit, terraform-docs, and tfenv.  If using Homebrew on macOS, you can install the dependencies using the following code.
 *
 * ```shell
 * brew install aws-vault direnv go pre-commit terraform-docs tfenv
 * pre-commit install --install-hooks
 * ```
 *
 * If using `direnv`, add a `.envrc.local` that sets the default AWS region, e.g., `export AWS_DEFAULT_REGION=us-west-2`.
 *
 * If using `tfenv`, then add a `.terraform-version` to the project root dir, with the version you would like to use.
 *
 *
 */
resource "aws_guardduty_detector" "this" {
  count  = var.deploy_detector ? 1 : 0
  enable = true
}

resource "aws_cloudwatch_event_rule" "this" {
  name        = "report-guard-duty-finding"
  description = "Report all guard duty findings"

  event_pattern = <<EOF
{
  "detail-type": [
    "GuardDuty Finding"
  ]
}
EOF
}

resource "aws_cloudwatch_event_target" "this" {
  rule = aws_cloudwatch_event_rule.this.name
  arn  = var.kinesis_stream_arn
}
