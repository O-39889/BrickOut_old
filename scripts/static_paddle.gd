extends StaticBody2D;
# StaticBody2D-based paddle (instead of KinematicBody2D).
# Its main use is to eliminate that weird bug when the KinematicBody2D
# paddle, even though it's not told to move, is still being pushed
# down by a ball in some cases (although I hope I fixed this thing
# and balls won't get 'jammed' like this (why did I write dis))

var current_width: int = 180;


func _unhandled_input(event: InputEvent) -> void:
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			position.x += event.relative.x * Global.mouse_sensitivity;
			position.x = clamp(position.x, 0,
					get_viewport_rect().size.x - current_width);
