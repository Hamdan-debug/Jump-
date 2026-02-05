extends Node
@onready var menu: CanvasLayer = %Menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
		menu.show()
		
	


func _on_play_pressed():
	get_tree().paused = false
	menu.hide() # Replace with function body.


func _on_close_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/starting_menu.tscn") # Replace with function body.
