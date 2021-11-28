########### ALB ###########

resource "aws_lb" "alb" {
  name               = "Final-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.pub_subnet.*.id
  # access_logs {
  #   bucket  = aws_s3_bucket.lb_log_s3.bucket
  #   prefix  = "test-lb"
  #   enabled = true
  # }

  depends_on = [
    aws_instance.web
  ]

 tags = {
    Name = "Final-alb"
  }

}


# alb tg

resource "aws_lb_target_group" "alb_tg" {
  name        = "Final-alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.my_vpc.id


  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 5
    matcher             = "200" 
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 2
    unhealthy_threshold = 2
  }
}


# alb listener

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}








########## NLB ###########

resource "aws_lb" "nlb" {
  name               = "Final-nlb"
  internal           = true
  load_balancer_type = "network"
  subnets            = aws_subnet.web_subnet.*.id
  depends_on = [
    aws_instance.was
  ]

   tags = {
    Name = "Final-nlb"
  }
}


# nlb tg

resource "aws_lb_target_group" "nlb_tg" {
  name = "Final-nlb-tg"
  port = 8080
  protocol = "TCP"
  vpc_id = aws_vpc.my_vpc.id
}


# nlb listener

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port = "8080"
  protocol = "TCP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.nlb_tg.arn
  }
  
}