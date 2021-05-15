tool
extends "res://scripts/brick.gd";
# Regular brick scene, the most common type.
# Has 'health' (or durability) - the amount of hits it takes to
# destroy it.


export(int, 2, 6, 2) var health: int;


func _ready() -> void:
	_change_color();
		


func _process(delta: float) -> void:
	if Engine.editor_hint:
		_change_color();
	if not Engine.editor_hint:
		pass;


func hit(ball: KinematicBody2D) -> void:
	if not Engine.editor_hint:
		# for checking the size of the ball, will need this later
	#	match ball.current_size:
	#		Global.BallSizes.BSIZE_SMALL:
	#			health -= 1;
	#		Global.BallSizes.BSIZE_REGULAR:
	#			health -= 2;
	#		Global.BallSizes.BSIZE_LARGE:
	#			health -= 4;
		health -= 2;
		if health < 0:
			health = 0;
		if health == 0:
			destroy();
		_change_color();


func destroy() -> void:
	if not Engine.editor_hint:
		queue_free();


func _change_color() -> void:
	if health <= 6:
			modulate = Color.red;
	if health <= 4:
		modulate = Color.orange;
	if health <= 2:
		modulate = Color.green;
