# resource "aws_s3_bucket" "lb_log_s3" {
#   bucket = "lb-logs-s3-ej"
#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::${var.alb_account_id}:root"
#       },
#       "Action": "s3:PutObject",
#       "Resource": "arn:aws:s3:::lb-logs-s3-ej/*"
#     }
#   ]
# }
#   EOF

#   acl    = "private"

#   tags = {
#     Name = "Final-lb-log-s3"
#   }
# }


# # S3 Endpoint
 resource "aws_vpc_endpoint" "s3_endpoint" {
   vpc_id       = aws_vpc.my_vpc.id
   service_name = "com.amazonaws.${var.region}.s3"
  
   tags = {
    Name = "Final-s3-endpoint"
   }
 }

# # Add vpc endpoint to route table of private subnet
 resource "aws_vpc_endpoint_route_table_association" "s3_endpoint_routetable" {
   count           = length(var.zone)
   vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
   route_table_id  = aws_route_table.rt_pri[count.index].id
 }


