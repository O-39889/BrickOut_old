extends StaticBody2D;
# Base brick scene; sort of an 'abstract class', it is not meant
# to be instantiated in a level directly.


# sort of a virtual method, to be overwritten by various types
# of bricks; actually, this type of brick (I'll rename it BaseBrick)
# shouldn't be created and used in levels at all
func hit(_ball: KinematicBody2D) -> void:
	_destroy();


func _destroy() -> void:
	queue_free();
