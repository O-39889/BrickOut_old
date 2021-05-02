extends KinematicBody2D;


signal hit_brick(ball, collision);

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
			emit_signal("hit_brick", self, collision);
			vel = vel.bounce(collision.normal);
		elif collision.collider.is_in_group("paddle"):
			var paddle_pos: Vector2 = collision.collider.position;
			var width: float = collision.collider.current_width;
			vel = BALL_SPEED * _paddle_bounce(collision.position,
					paddle_pos, width);


func _paddle_bounce(collision_point: Vector2,
		paddle_pos: Vector2,
		paddle_width: float) -> Vector2:
	var cp_x: float = collision_point.x;
	var pp_x: float = paddle_pos.x;
	
	var rot: float = range_lerp(cp_x, pp_x, pp_x + paddle_width,
			-80.0, 80.0);
	
	var vec: Vector2 = Vector2.UP.rotated(deg2rad(rot));
	return vec;
