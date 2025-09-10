# ECR Repository
resource "aws_ecr_repository" "app_repo" {
  name = var.app_name
}

# IAM Role for App Runner
resource "aws_iam_role" "apprunner_role" {
  name = "${var.app_name}-apprunner-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "build.apprunner.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "apprunner_ecr_access" {
  role       = aws_iam_role.apprunner_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

data "aws_caller_identity" "current" {}

# App Runner Service
resource "aws_apprunner_service" "app_service" {
  service_name = "${var.app_name}-service"

  source_configuration {
    image_repository {
      image_identifier      = "${aws_ecr_repository.app_repo.repository_url}:latest"
      image_repository_type = "ECR"

      image_configuration {
        port = "8080"
      }
    }

    # Correct place for auto-deployments
    auto_deployments_enabled = true

    authentication_configuration {
      access_role_arn = aws_iam_role.apprunner_role.arn
    }
  }

  instance_configuration {
    cpu    = "1024"
    memory = "2048"
  }
}
