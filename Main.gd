extends Node2D;


func init_walls() -> void:
	$WallL/CollisionShape2D.shape.b.y = get_viewport_rect().size.y;
	
	$WallR/CollisionShape2D.shape.a.x = get_viewport_rect().size.x;
	$WallR/CollisionShape2D.shape.b.x = get_viewport_rect().size.x;
	$WallR/CollisionShape2D.shape.b.y = get_viewport_rect().size.y;
	
	$Ceiling/CollisionShape2D.shape.b.x = get_viewport_rect().size.x


func reset_paddle() -> void:
	var vec: Vector2 = Vector2((get_viewport_rect().size.x -
			$Paddle/CollisionShape2D.shape.b.x) / 2,
			get_viewport_rect().size.y - 30)
	
	$Paddle.position = vec;


func _ready() -> void:
	init_walls();
	reset_paddle();
