extends KinematicBody2D;


signal hit(ball, collision);

const BALL_SPEED: int = 250;
var vel: Vector2 = Vector2.ZERO;


func _ready() -> void:
	vel = Vector2(1, 1).normalized() * BALL_SPEED;


func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(vel * delta);
	if collision:
		if collision.collider.is_in_group("walls"):
			vel = vel.bounce(collision.normal);
		elif collision.collider.is_in_group("bricks"):
			pass;
		elif collision.collider.is_in_group("paddle"):
			var paddle_pos: Vector2 = collision.collider.position;
			var width: float = collision.collider.current_width;
			vel = BALL_SPEED * _paddle_bounce(collision.position,
					paddle_pos, width);
#			vel = BALL_SPEED * paddle_bounce(paddle_pos(collision));


func _paddle_bounce(collision_point: Vector2,
		paddle_pos: Vector2,
		paddle_width: float) -> Vector2:
	var cp_x: float = collision_point.x;
	var pp_x: float = paddle_pos.x;
#	print("Collision:\t", cp_x);
#	print("Paddle left:\t", pp_x);
#	print("Paddle right:\t", pp_x + paddle_width)
	var rot: float = range_lerp(cp_x, pp_x, pp_x + paddle_width,
			-80.0, 80.0);
	
	var vec: Vector2 = Vector2.UP.rotated(deg2rad(rot));
	return vec;


#func paddle_pos(collision: KinematicCollision2D) -> float:
#	var distance: float = collision.position.x - collision.collider.position.x;
#
#	print(collision.position.x, " - ",
#			collision.collider.position.x, " = ",
#			distance);
#	print(distance / collision.collider.current_width);
#
#	return distance / collision.collider.current_width;
#
#
#func paddle_bounce(pos: float) -> Vector2:
#	# pos is the number between 0 and 1
#	# (0 — collision point is in the left corner of the paddle,
#	# 1 — collision point is in the right corner of the paddle)
#	# returned by paddle_pos
#	var bounce_angle: float = 160 * pos + 10;
#	print("Angle = ", -bounce_angle);
#	# KOSTYL' ALERT!
#	# AUTONOMOUS UNITS SUBSU- well, actually no
#	# so, kostyl' is this MINUS SIGN on the cos function, without it
#	# the ball bounces in the wrong direction (right instead of left,
#	# left instead of right);
#	# minus signs on bounce_angle are not kostyl's (probably (at least
#	# I said so)), it's just because Godot's angles are CW (with
#	# 0 being still on the right, so angles at the 'top' are negative)
#	# and math angles (used in trigonometric functions) are CCW
#	return Vector2(-cos(deg2rad(-bounce_angle)),
#			sin(deg2rad(-bounce_angle))).normalized();
