extends Node

@onready var animation :AnimationPlayer = $AnimationPlayer
@onready var button_yes : Button = $YES
@onready var button_no : Button = $NO
@onready var anim_timer: Timer = $AnimTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_yes_pressed() -> void:
	button_yes.hide()
	print("Button Clicked")
	animation.play("tutorial")
	anim_timer.start(10)
	
	if anim_timer.is_stopped():
		_on_animation_player_animation_finished("tutorial")
	



func _on_no_pressed() -> void:
	button_no.hide()
	get_tree().change_scene_to_file("res://Scenes/levelmenu.tscn") 


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://Scenes/levelmenu.tscn")
