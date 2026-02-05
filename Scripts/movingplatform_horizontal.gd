

# Called when the node enters the scene tree for the first time.
extends Path2D


@export var path_time = 1.0
@export var pathfollow2d: PathFollow2D



# Called when the node enters the scene tree for the first time.
func _ready():
	move_tween()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func move_tween():
	var tween = get_tree().create_tween().set_loops()
	tween.tween_property(pathfollow2d, "progress_ratio", 1.0, path_time)
	tween.tween_property(pathfollow2d, "progress_ratio", 0.0, path_time)
