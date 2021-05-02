extends Node2D;
# Script for Main scene (more like a level template actually: will
# contain all the stuff necessary specifically for gameplay)


const Ball := preload("res://scenes/Ball.tscn");

onready var window_width: float = get_viewport_rect().size.x;
onready var window_height: float = get_viewport_rect().size.y;

var balls: Array = [];

onready var wall_l := get_node("WallL");
onready var wall_r := get_node("WallR");
onready var ceiling := get_node("Ceiling");
onready var paddle := get_node("Paddle");


func _ready() -> void:
	_init_walls();
	_reset_paddle();
	_init_ball();


func _physics_process(delta):
	# debug stuff
	if Input.is_action_just_pressed("enter"):
		get_tree().reload_current_scene();
	if Input.is_action_just_pressed("f1"):
		for wall in get_tree().get_nodes_in_group("walls"):
			print(wall.get_node("CollisionShape2D").shape.a);
			print(wall.get_node("CollisionShape2D").shape.b);
			print("");


func _init_walls() -> void:
	wall_l.init_wall(Vector2(0, 0), Vector2(0, window_height));
	wall_r.init_wall(Vector2(window_width, 0),
			Vector2(window_width, window_height));
	ceiling.init_wall(Vector2(0, 0), Vector2(window_width, 0));
#	$WallL/CollisionShape2D.shape.b.y = get_viewport_rect().size.y;
#
#	$WallR/CollisionShape2D.shape.a.x = get_viewport_rect().size.x;
#	$WallR/CollisionShape2D.shape.b.x = get_viewport_rect().size.x;
#	$WallR/CollisionShape2D.shape.b.y = get_viewport_rect().size.y;
#
#	$Ceiling/CollisionShape2D.shape.b.x = get_viewport_rect().size.x


func _reset_paddle() -> void:
	var vec: Vector2 = Vector2((get_viewport_rect().size.x -
			$Paddle/CollisionShape2D.shape.b.x) / 2,
			get_viewport_rect().size.y - 30)
	
	$Paddle.position = vec;


func _init_ball() -> void:
	var vec: Vector2 = Vector2(15, 15);
	var ball := Ball.instance();
	ball.position = vec;
	balls.append(ball);
	add_child(ball);
