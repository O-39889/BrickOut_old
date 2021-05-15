extends StaticBody2D;


func hit(_ball: KinematicBody2D) -> void:
	queue_free();
