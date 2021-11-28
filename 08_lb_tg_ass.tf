########## ALB ###########

resource "aws_lb_target_group_attachment" "alb_tg_ass_a" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = aws_instance.web[0].id
  port             = 80
}

resource "aws_lb_target_group_attachment" "alb_tg_ass_c" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = aws_instance.web[1].id
  port             = 80
}

########## NLB ###########

resource "aws_lb_target_group_attachment" "nlb_tg_ass_a" {
  target_group_arn = aws_lb_target_group.nlb_tg.arn
  target_id        = aws_instance.was[0].id
  port             = 8080
}

resource "aws_lb_target_group_attachment" "nlb_tg_ass_c" {
  target_group_arn = aws_lb_target_group.nlb_tg.arn
  target_id        = aws_instance.was[1].id
  port             = 8080
}

