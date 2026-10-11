variable "scheduler_schedules" {
  description = <<EOT
Map of scheduler_schedules, attributes below
Required:
    - schedule_expression
    - flexible_time_window (block):
        - maximum_window_in_minutes (optional)
        - mode (required)
    - target (block):
        - arn (required)
        - dead_letter_config (optional, block):
            - arn (required)
        - ecs_parameters (optional, block):
            - capacity_provider_strategy (optional, block):
                - base (optional)
                - capacity_provider (required)
                - weight (optional)
            - enable_ecs_managed_tags (optional)
            - enable_execute_command (optional)
            - group (optional)
            - launch_type (optional)
            - network_configuration (optional, block):
                - assign_public_ip (optional)
                - security_groups (optional)
                - subnets (required)
            - placement_constraints (optional, block):
                - expression (optional)
                - type (required)
            - placement_strategy (optional, block):
                - field (optional)
                - type (required)
            - platform_version (optional)
            - propagate_tags (optional)
            - reference_id (optional)
            - tags (optional)
            - task_count (optional)
            - task_definition_arn (required)
        - eventbridge_parameters (optional, block):
            - detail_type (required)
            - source (required)
        - input (optional)
        - kinesis_parameters (optional, block):
            - partition_key (required)
        - retry_policy (optional, block):
            - maximum_event_age_in_seconds (optional)
            - maximum_retry_attempts (optional)
        - role_arn (required)
        - sagemaker_pipeline_parameters (optional, block):
            - pipeline_parameter (optional, block):
                - name (required)
                - value (required)
        - sqs_parameters (optional, block):
            - message_group_id (optional)
Optional:
    - action_after_completion
    - description
    - end_date
    - group_name
    - kms_key_arn
    - name
    - name_prefix
    - region
    - schedule_expression_timezone
    - start_date
    - state
EOT

  type = map(object({
    schedule_expression          = string
    action_after_completion      = optional(string)
    description                  = optional(string)
    end_date                     = optional(string)
    group_name                   = optional(string)
    kms_key_arn                  = optional(string)
    name                         = optional(string)
    name_prefix                  = optional(string)
    region                       = optional(string)
    schedule_expression_timezone = optional(string)
    start_date                   = optional(string)
    state                        = optional(string)
    flexible_time_window = object({
      maximum_window_in_minutes = optional(number)
      mode                      = string
    })
    target = object({
      arn = string
      dead_letter_config = optional(object({
        arn = string
      }))
      ecs_parameters = optional(object({
        capacity_provider_strategy = optional(list(object({
          base              = optional(number)
          capacity_provider = string
          weight            = optional(number)
        })))
        enable_ecs_managed_tags = optional(bool)
        enable_execute_command  = optional(bool)
        group                   = optional(string)
        launch_type             = optional(string)
        network_configuration = optional(object({
          assign_public_ip = optional(bool)
          security_groups  = optional(set(string))
          subnets          = set(string)
        }))
        placement_constraints = optional(list(object({
          expression = optional(string)
          type       = string
        })))
        placement_strategy = optional(list(object({
          field = optional(string)
          type  = string
        })))
        platform_version    = optional(string)
        propagate_tags      = optional(string)
        reference_id        = optional(string)
        tags                = optional(map(string))
        task_count          = optional(number)
        task_definition_arn = string
      }))
      eventbridge_parameters = optional(object({
        detail_type = string
        source      = string
      }))
      input = optional(string)
      kinesis_parameters = optional(object({
        partition_key = string
      }))
      retry_policy = optional(object({
        maximum_event_age_in_seconds = optional(number)
        maximum_retry_attempts       = optional(number)
      }))
      role_arn = string
      sagemaker_pipeline_parameters = optional(object({
        pipeline_parameter = optional(list(object({
          name  = string
          value = string
        })))
      }))
      sqs_parameters = optional(object({
        message_group_id = optional(string)
      }))
    })
  }))
  validation {
    condition = alltrue([
      for k, v in var.scheduler_schedules : (
        v.target.ecs_parameters == null || (v.target.ecs_parameters.capacity_provider_strategy == null || (length(v.target.ecs_parameters.capacity_provider_strategy) <= 6))
      )
    ])
    error_message = "Each capacity_provider_strategy list must contain at most 6 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.scheduler_schedules : (
        v.target.ecs_parameters == null || (v.target.ecs_parameters.placement_constraints == null || (length(v.target.ecs_parameters.placement_constraints) <= 10))
      )
    ])
    error_message = "Each placement_constraints list must contain at most 10 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.scheduler_schedules : (
        v.target.ecs_parameters == null || (v.target.ecs_parameters.placement_strategy == null || (length(v.target.ecs_parameters.placement_strategy) <= 5))
      )
    ])
    error_message = "Each placement_strategy list must contain at most 5 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.scheduler_schedules : (
        v.target.sagemaker_pipeline_parameters == null || (v.target.sagemaker_pipeline_parameters.pipeline_parameter == null || (length(v.target.sagemaker_pipeline_parameters.pipeline_parameter) <= 200))
      )
    ])
    error_message = "Each pipeline_parameter list must contain at most 200 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.scheduler_schedules : (
        v.flexible_time_window.maximum_window_in_minutes == null || (v.flexible_time_window.maximum_window_in_minutes >= 1 && v.flexible_time_window.maximum_window_in_minutes <= 1440)
      )
    ])
    error_message = "must be between 1 and 1440"
  }
  validation {
    condition = alltrue([
      for k, v in var.scheduler_schedules : (
        v.schedule_expression_timezone == null || (length(v.schedule_expression_timezone) >= 1 && length(v.schedule_expression_timezone) <= 50)
      )
    ])
    error_message = "must be between 1 and 50 characters"
  }
  # Note: 34 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

