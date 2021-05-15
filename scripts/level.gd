extends Node2D;


const Ball := preload("res://scenes/Ball.tscn");
const Powerup := preload("res://scenes/Powerup.tscn");

onready var screen_width: float = get_viewport_rect().size.x;
onready var screen_height: float = get_viewport_rect().size.y;

var balls: Array = [];
var powerups: Array = [];

onready var wall_l := get_node("WallL");
onready var wall_r := get_node("WallR");
onready var ceiling := get_node("Ceiling");
onready var paddle := get_node("Paddle");

var _mouse_captured: bool = false;


func _ready() -> void:
	set_mouse_capture(true);
	
	_init_walls();
	_reset_paddle();
	var pos: Vector2 = Vector2(paddle.position.x + paddle.current_width / 2,
				paddle.position.y - Global.BALL_SIZES[Global.BallSizes.BSIZE_DEFAULT] * 2);
	create_ball(pos);


func _physics_process(delta):
	# debug stuff
	if Input.is_action_just_pressed("debug_space"):
		var pos: Vector2 = Vector2(paddle.position.x + paddle.current_width / 2,
				paddle.position.y - Global.BALL_SIZES[Global.BallSizes.BSIZE_DEFAULT]);
		create_ball(pos);
	if Input.is_action_just_pressed("debug_r"):
		# this fixes the bug with balls emitting the signal
		# at level restart; however, this is only some debug
		# stuff, so I'm going to rewrite it later anyway
#		for b in balls:
#			b.disconnect("lost", self, "_on_Ball_lost");
		get_tree().reload_current_scene();
	if Input.is_action_just_pressed("debug_1"):
		var powerup = create_powerup(Vector2(screen_width,
						screen_height) / 2);
		powerups.append(powerup);
		add_child(powerup);


# apparently, what Git didn't like is that, despite these functions being
# separate and not conflicting with each other, they used to occupy the
# same lines lol
func create_ball(pos: Vector2,
		velocity: Vector2 = Vector2.UP * Global.BALL_SPEEDS[Global.BallSpeeds.BSPEED_DEFAULT]) -> void:
	var ball := Ball.instance();
	
	ball.position = pos;
	ball.vel = velocity;
	balls.append(ball);
	ball.connect("hit_brick", self, "_on_Ball_hit_brick");
	ball.connect("lost", self, "_on_Ball_lost");
	
	add_child(ball);


# ouch
func _on_Ball_hit_brick(ball: KinematicBody2D,
		collision: KinematicCollision2D) -> void:
	# for some reason, you cannot access the 'modulate' property
	# of collision.collider (StaticBody2D, even though it inherits
	# CanvasItem)
	assert(collision.collider.has_method("hit"));
	collision.collider.call("hit", ball);


func _on_Ball_lost(ball: KinematicBody2D) -> void:
	balls.erase(ball);
	print("Ball lost! :(");
	ball.queue_free();
	if balls.empty():
		# calling reload_current_scene() for some reason causes
		# the VisibilityNotifiers2D in remaining balls to emit
		# screen_exited signal
		get_tree().reload_current_scene();


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT:
			if event.pressed and _mouse_captured:
				set_mouse_capture(false);
				print("Paused!");
		elif event.button_index == BUTTON_LEFT:
			if event.pressed and not _mouse_captured:
				set_mouse_capture(true);
				print("Unpaused!");


# I don't remember why I created this function; as you can see, its
# main purpose is to ensure that _mouse_captured property is always
# in sync with the mouse mode; however, I really cannot remember
# why did I need the _mouse_captured property in the first place
func set_mouse_capture(captured: bool) -> void:
	if captured:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
		_mouse_captured = true;
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
		_mouse_captured = false;


func create_powerup(pos: Vector2) -> KinematicBody2D:
	var powerup := Powerup.instance();
	powerup.position = pos;
	return (powerup as KinematicBody2D);


func _init_walls() -> void:
	wall_l.init_wall(Vector2(0, 0), Vector2(0, screen_height));
	wall_r.init_wall(Vector2(screen_width, 0),
			Vector2(screen_width, screen_height));
	ceiling.init_wall(Vector2(0, 0), Vector2(screen_width, 0));


func _reset_paddle() -> void:
	var vec: Vector2 = Vector2((screen_width - paddle.current_width) / 2,
			screen_height - 30);
	paddle.position = vec;
