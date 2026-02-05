extends CanvasLayer

@onready var heart_1: TextureRect = %Heart1
@onready var heart_2: TextureRect = %Heart2
@onready var heart_3: TextureRect = %Heart3

@export var player: PlayerController
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func health():
	if player.health == 2:
		heart_1.hide()
	elif player.health == 1:
		heart_2.hide()
	elif player.health == 0:
		heart_3.hide()
