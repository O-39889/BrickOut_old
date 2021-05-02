extends StaticBody2D;


func _ready() -> void:
	# all code controlling the mouse cursor should be later
	# moved to the Main node
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	position.x = get_viewport_rect().size.x / 2 - 90;
	position.y = get_viewport_rect().size.y - 30;


func _unhandled_input(event: InputEvent) -> void:
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			position.x += event.relative.x * Global.mouse_sensitivity;
			position.x = clamp(position.x, 0,
					get_viewport_rect().size.x - 180);
