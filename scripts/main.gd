extends Node2D;
# Script for Main scene (more like a level template actually: will
# contain all the stuff necessary specifically for gameplay)


const Ball := preload("res://scenes/Ball.tscn");

onready var screen_width: float = get_viewport_rect().size.x;
onready var screen_height: float = get_viewport_rect().size.y;

var balls: Array = [];

onready var wall_l := get_node("WallL");
onready var wall_r := get_node("WallR");
onready var ceiling := get_node("Ceiling");
onready var paddle := get_node("StaticPaddle");

var _mouse_captured: bool = false;


func _ready() -> void:
	set_mouse_capture(true);
	
	_init_walls();
	_reset_paddle();
	_init_ball();


func _physics_process(delta):
	# debug stuff
	if Input.is_action_just_pressed("enter"):
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


func _init_walls() -> void:
	wall_l.init_wall(Vector2(0, 0), Vector2(0, screen_height));
	wall_r.init_wall(Vector2(screen_width, 0),
			Vector2(screen_width, screen_height));
	ceiling.init_wall(Vector2(0, 0), Vector2(screen_width, 0));


func _reset_paddle() -> void:
	var vec: Vector2 = Vector2((screen_width - paddle.current_width) / 2,
			screen_height - 30);
	paddle.position = vec;


func _init_ball() -> void:
	var vec: Vector2 = Vector2(320, 320);
	var ball := Ball.instance();
	ball.position = vec;
	balls.append(ball);
	add_child(ball);
