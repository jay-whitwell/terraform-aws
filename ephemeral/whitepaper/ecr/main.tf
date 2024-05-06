resource "aws_ecr_repository" "repo" {
  name = "php-app"
  image_scanning_configuration {
    scan_on_push = true
  }
}