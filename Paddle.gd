extends KinematicBody2D;


const SPEED: int = 240;


func _physics_process(delta) -> void:
	var vel: Vector2 = Vector2.ZERO;
	
	if Input.is_action_pressed("right"):
		vel.x += 1;
	if Input.is_action_pressed("left"):
		vel.x -= 1;
	vel *= SPEED;
	
	move_and_collide(vel * delta);
