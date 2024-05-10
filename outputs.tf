# # output "public_ip" {
# #   value = aws_instance.name_of_the_1st_block.public_ip
# # }

# # output "private_ip" {
# #   value = aws_instance.name_of_the_1st_block.private_ip
# # }

# output "s3_arn" {
#   value = aws_s3_bucket.hw-s3.arn
# }

# output "s3_id" {
#   value = aws_s3_bucket.hw-s3.id
# }

# output "s3_region" {
#   value = aws_s3_bucket.hw-s3.region
# }

output "ec2_arn" {
  value = aws_instance.master-controller.arn
}

output "ec2_id" {
  value = aws_instance.master-controller.id
}

# output "iam_user_name" {
#   value = aws_iam_user.gitlab-apps-user.name
# }

# output "iam_user_arn" {
#   value = aws_iam_user.gitlab-apps-user.arn
# }

# output "iam_user_id" {
#   value = aws_iam_user.gitlab-apps-user.id
# }

output "ubuntu_ami_id" {
  value = data.aws_ami.latest.id
}