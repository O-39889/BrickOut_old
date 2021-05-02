extends StaticBody2D;


func hit(ball: KinematicBody2D) -> void:
	queue_free();
