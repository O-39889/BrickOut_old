extends KinematicBody2D;


const PADDLE_SPEED: int = 240;

var current_width: int = 180;


func _physics_process(delta: float) -> void:
	var vel: Vector2 = Vector2.ZERO;
	
	if Input.is_action_pressed("right"):
		vel.x += 1;
	if Input.is_action_pressed("left"):
		vel.x -= 1;
	vel *= PADDLE_SPEED;
	
	move_and_collide(vel * delta);
