extends Path2D
class_name MovingPlatform


@export var path_follow_2D : PathFollow2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func move_tween():
	var tween = get_tree().create_tween().set_loops()
	tween.tween_property(path_follow_2D, "progress_ratio", 1.0, 1.0)
	tween.tween_property(path_follow_2D, "progress_ratio", 0.0, 1.0)
	
