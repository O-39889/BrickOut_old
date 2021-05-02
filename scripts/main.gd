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
onready var paddle := get_node("Paddle");


func _ready() -> void:
	_init_walls();
	_reset_paddle();
	var pos: Vector2 = Vector2(paddle.position.x + paddle.current_width / 2,
				paddle.position.y - Global.BALL_SIZES[Global.BallSizes.BSIZE_DEFAULT] * 2);
	create_ball(pos);


func _physics_process(delta):
	# debug stuff
	if Input.is_action_just_pressed("enter"):
		# lol, if you just spam enter, the paddle slowly starts to
		# sink down (because — shhh — KinematicBody2D actually sucks)
		# (or maybe it doesn't) (or maybe it does)
		var pos: Vector2 = Vector2(paddle.position.x + paddle.current_width / 2,
				paddle.position.y - Global.BALL_SIZES[Global.BallSizes.BSIZE_DEFAULT]);
		create_ball(pos);
	if Input.is_action_just_pressed("f1"):
		get_tree().reload_current_scene();


func create_ball(pos: Vector2,
		velocity: Vector2 = Vector2.UP * Global.BALL_SPEEDS[Global.BallSpeeds.BSPEED_DEFAULT]) -> void:
	var ball := Ball.instance();
	ball.position = pos;
	ball.vel = velocity;
	balls.append(ball);
	add_child(ball);


func _init_walls() -> void:
	wall_l.init_wall(Vector2(0, 0), Vector2(0, screen_height));
	wall_r.init_wall(Vector2(screen_width, 0),
			Vector2(screen_width, screen_height));
	ceiling.init_wall(Vector2(0, 0), Vector2(screen_width, 0));


func _reset_paddle() -> void:
	var vec: Vector2 = Vector2((screen_width - paddle.current_width) / 2,
			screen_height - 30);
	paddle.position = vec;
