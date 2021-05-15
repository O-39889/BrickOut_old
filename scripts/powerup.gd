extends KinematicBody2D;


signal picked_up(what);


const POWERUP_GRAVITY: float = 2.0;
const INITIAL_SPEED: float = 150.0;

var type: int;
var vel: Vector2;
# while there are no sprites for the powerup, I'll just use labels
# for powerup names
onready var debug_label: Label = get_node("DebugLabel");
onready var vis_notifier: VisibilityNotifier2D = get_node("VisibilityNotifier2D");


func _ready() -> void:
	_launch();


func _physics_process(delta: float) -> void:
	vel += Vector2.DOWN * POWERUP_GRAVITY;
	
	var collision: KinematicCollision2D = move_and_collide(vel * delta);
	if collision:
		emit_signal("picked_up", self);
		# so you don't nag about disappearing off-screen
		vis_notifier.disconnect("screen_exited", self,
				"_on_VisibilityNotifier2D_screen_exited");
		queue_free();


func _on_VisibilityNotifier2D_screen_exited():
	queue_free();


func _launch() -> void:
	var angle: float = rand_range(-20.0, 20.0);
	vel = (Vector2.UP * INITIAL_SPEED).rotated(deg2rad(angle));
