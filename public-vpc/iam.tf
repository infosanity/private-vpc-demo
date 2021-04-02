resource "aws_iam_role" "ssm_managed_role" {
  name               = "ssm_managed_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags = merge(
    var.tags,
    {}
  )
}

resource "aws_iam_instance_profile" "ssm_managed_profile" {
  name = "ssm_managed_profile"
  role = aws_iam_role.ssm_managed_role.name
}

resource "aws_iam_role_policy_attachment" "ssm_managed_role_policy" {
  role       = aws_iam_role.ssm_managed_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_policy_attachment" {
  role       = aws_iam_role.ssm_managed_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}