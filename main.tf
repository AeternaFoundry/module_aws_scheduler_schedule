resource "aws_scheduler_schedule" "scheduler_schedules" {
  for_each = var.scheduler_schedules

  schedule_expression          = each.value.schedule_expression
  action_after_completion      = each.value.action_after_completion
  description                  = each.value.description
  end_date                     = each.value.end_date
  group_name                   = each.value.group_name
  kms_key_arn                  = each.value.kms_key_arn
  name                         = each.value.name
  name_prefix                  = each.value.name_prefix
  region                       = each.value.region
  schedule_expression_timezone = each.value.schedule_expression_timezone
  start_date                   = each.value.start_date
  state                        = each.value.state

  flexible_time_window {
    maximum_window_in_minutes = each.value.flexible_time_window.maximum_window_in_minutes
    mode                      = each.value.flexible_time_window.mode
  }

  target {
    arn = each.value.target.arn
    dynamic "dead_letter_config" {
      for_each = each.value.target.dead_letter_config != null ? [each.value.target.dead_letter_config] : []
      content {
        arn = dead_letter_config.value.arn
      }
    }
    dynamic "ecs_parameters" {
      for_each = each.value.target.ecs_parameters != null ? [each.value.target.ecs_parameters] : []
      content {
        dynamic "capacity_provider_strategy" {
          for_each = ecs_parameters.value.capacity_provider_strategy != null ? ecs_parameters.value.capacity_provider_strategy : []
          content {
            base              = capacity_provider_strategy.value.base
            capacity_provider = capacity_provider_strategy.value.capacity_provider
            weight            = capacity_provider_strategy.value.weight
          }
        }
        enable_ecs_managed_tags = ecs_parameters.value.enable_ecs_managed_tags
        enable_execute_command  = ecs_parameters.value.enable_execute_command
        group                   = ecs_parameters.value.group
        launch_type             = ecs_parameters.value.launch_type
        dynamic "network_configuration" {
          for_each = ecs_parameters.value.network_configuration != null ? [ecs_parameters.value.network_configuration] : []
          content {
            assign_public_ip = network_configuration.value.assign_public_ip
            security_groups  = network_configuration.value.security_groups
            subnets          = network_configuration.value.subnets
          }
        }
        dynamic "placement_constraints" {
          for_each = ecs_parameters.value.placement_constraints != null ? ecs_parameters.value.placement_constraints : []
          content {
            expression = placement_constraints.value.expression
            type       = placement_constraints.value.type
          }
        }
        dynamic "placement_strategy" {
          for_each = ecs_parameters.value.placement_strategy != null ? ecs_parameters.value.placement_strategy : []
          content {
            field = placement_strategy.value.field
            type  = placement_strategy.value.type
          }
        }
        platform_version    = ecs_parameters.value.platform_version
        propagate_tags      = ecs_parameters.value.propagate_tags
        reference_id        = ecs_parameters.value.reference_id
        tags                = ecs_parameters.value.tags
        task_count          = ecs_parameters.value.task_count
        task_definition_arn = ecs_parameters.value.task_definition_arn
      }
    }
    dynamic "eventbridge_parameters" {
      for_each = each.value.target.eventbridge_parameters != null ? [each.value.target.eventbridge_parameters] : []
      content {
        detail_type = eventbridge_parameters.value.detail_type
        source      = eventbridge_parameters.value.source
      }
    }
    input = each.value.target.input
    dynamic "kinesis_parameters" {
      for_each = each.value.target.kinesis_parameters != null ? [each.value.target.kinesis_parameters] : []
      content {
        partition_key = kinesis_parameters.value.partition_key
      }
    }
    dynamic "retry_policy" {
      for_each = each.value.target.retry_policy != null ? [each.value.target.retry_policy] : []
      content {
        maximum_event_age_in_seconds = retry_policy.value.maximum_event_age_in_seconds
        maximum_retry_attempts       = retry_policy.value.maximum_retry_attempts
      }
    }
    role_arn = each.value.target.role_arn
    dynamic "sagemaker_pipeline_parameters" {
      for_each = each.value.target.sagemaker_pipeline_parameters != null ? [each.value.target.sagemaker_pipeline_parameters] : []
      content {
        dynamic "pipeline_parameter" {
          for_each = sagemaker_pipeline_parameters.value.pipeline_parameter != null ? sagemaker_pipeline_parameters.value.pipeline_parameter : []
          content {
            name  = pipeline_parameter.value.name
            value = pipeline_parameter.value.value
          }
        }
      }
    }
    dynamic "sqs_parameters" {
      for_each = each.value.target.sqs_parameters != null ? [each.value.target.sqs_parameters] : []
      content {
        message_group_id = sqs_parameters.value.message_group_id
      }
    }
  }
}

