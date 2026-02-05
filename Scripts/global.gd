extends Node
var player = null

# This will store the current level path automatically
var current_level_path : String = ""

# List of all levels in order
var level_list = [
	"res://Scenes/level_1.tscn",
	"res://Scenes/level_2.tscn",
	"res://Scenes/level_3.tscn"
]

func _ready() -> void:
	Global.current_level_path = scene_file_path
	print("Global path updated to: ", Global.current_level_path)
	
func load_next_level():
	var current_index = level_list.find(current_level_path)
	
	if current_index != -1 and current_index < level_list.size() - 1:
		var next_path = level_list[current_index + 1]
		get_tree().change_scene_to_file(next_path)
	else:
		# Go back to menu if no more levels
		get_tree().change_scene_to_file("res://Scenes/starting_menu.tscn")

func _process(delta: float) -> void:
	pass
