extends StaticBody2D;


func init_wall(vec_a: Vector2, vec_b: Vector2) -> void:
	$CollisionShape2D.shape.a = vec_a;
	$CollisionShape2D.shape.b = vec_b;
