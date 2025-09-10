output "ecr_repo_url" {
  value = aws_ecr_repository.app_repo.repository_url
}

output "apprunner_service_url" {
  value = aws_apprunner_service.app_service.service_url
}
