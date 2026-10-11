output "scheduler_schedules_id" {
  description = "Map of id values across all scheduler_schedules, keyed the same as var.scheduler_schedules"
  value       = { for k, v in aws_scheduler_schedule.scheduler_schedules : k => v.id if v.id != null && length(v.id) > 0 }
}
output "scheduler_schedules_action_after_completion" {
  description = "Map of action_after_completion values across all scheduler_schedules, keyed the same as var.scheduler_schedules"
  value       = { for k, v in aws_scheduler_schedule.scheduler_schedules : k => v.action_after_completion if v.action_after_completion != null && length(v.action_after_completion) > 0 }
}
output "scheduler_schedules_arn" {
  description = "Map of arn values across all scheduler_schedules, keyed the same as var.scheduler_schedules"
  value       = { for k, v in aws_scheduler_schedule.scheduler_schedules : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "scheduler_schedules_description" {
  description = "Map of description values across all scheduler_schedules, keyed the same as var.scheduler_schedules"
  value       = { for k, v in aws_scheduler_schedule.scheduler_schedules : k => v.description if v.description != null && length(v.description) > 0 }
}
output "scheduler_schedules_end_date" {
  description = "Map of end_date values across all scheduler_schedules, keyed the same as var.scheduler_schedules"
  value       = { for k, v in aws_scheduler_schedule.scheduler_schedules : k => v.end_date if v.end_date != null && length(v.end_date) > 0 }
}
output "scheduler_schedules_flexible_time_window" {
  description = "Map of flexible_time_window values across all scheduler_schedules, keyed the same as var.scheduler_schedules"
  value       = { for k, v in aws_scheduler_schedule.scheduler_schedules : k => one(v.flexible_time_window) if v.flexible_time_window != null && length(v.flexible_time_window) > 0 }
}
output "scheduler_schedules_group_name" {
  description = "Map of group_name values across all scheduler_schedules, keyed the same as var.scheduler_schedules"
  value       = { for k, v in aws_scheduler_schedule.scheduler_schedules : k => v.group_name if v.group_name != null && length(v.group_name) > 0 }
}
output "scheduler_schedules_kms_key_arn" {
  description = "Map of kms_key_arn values across all scheduler_schedules, keyed the same as var.scheduler_schedules"
  value       = { for k, v in aws_scheduler_schedule.scheduler_schedules : k => v.kms_key_arn if v.kms_key_arn != null && length(v.kms_key_arn) > 0 }
}
output "scheduler_schedules_name" {
  description = "Map of name values across all scheduler_schedules, keyed the same as var.scheduler_schedules"
  value       = { for k, v in aws_scheduler_schedule.scheduler_schedules : k => v.name if v.name != null && length(v.name) > 0 }
}
output "scheduler_schedules_name_prefix" {
  description = "Map of name_prefix values across all scheduler_schedules, keyed the same as var.scheduler_schedules"
  value       = { for k, v in aws_scheduler_schedule.scheduler_schedules : k => v.name_prefix if v.name_prefix != null && length(v.name_prefix) > 0 }
}
output "scheduler_schedules_region" {
  description = "Map of region values across all scheduler_schedules, keyed the same as var.scheduler_schedules"
  value       = { for k, v in aws_scheduler_schedule.scheduler_schedules : k => v.region if v.region != null && length(v.region) > 0 }
}
output "scheduler_schedules_schedule_expression" {
  description = "Map of schedule_expression values across all scheduler_schedules, keyed the same as var.scheduler_schedules"
  value       = { for k, v in aws_scheduler_schedule.scheduler_schedules : k => v.schedule_expression if v.schedule_expression != null && length(v.schedule_expression) > 0 }
}
output "scheduler_schedules_schedule_expression_timezone" {
  description = "Map of schedule_expression_timezone values across all scheduler_schedules, keyed the same as var.scheduler_schedules"
  value       = { for k, v in aws_scheduler_schedule.scheduler_schedules : k => v.schedule_expression_timezone if v.schedule_expression_timezone != null && length(v.schedule_expression_timezone) > 0 }
}
output "scheduler_schedules_start_date" {
  description = "Map of start_date values across all scheduler_schedules, keyed the same as var.scheduler_schedules"
  value       = { for k, v in aws_scheduler_schedule.scheduler_schedules : k => v.start_date if v.start_date != null && length(v.start_date) > 0 }
}
output "scheduler_schedules_state" {
  description = "Map of state values across all scheduler_schedules, keyed the same as var.scheduler_schedules"
  value       = { for k, v in aws_scheduler_schedule.scheduler_schedules : k => v.state if v.state != null && length(v.state) > 0 }
}
output "scheduler_schedules_target" {
  description = "Map of target values across all scheduler_schedules, keyed the same as var.scheduler_schedules"
  value       = { for k, v in aws_scheduler_schedule.scheduler_schedules : k => one(v.target) if v.target != null && length(v.target) > 0 }
}

