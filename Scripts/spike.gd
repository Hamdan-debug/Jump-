extends StaticBody2D
class_name Spike
@export var player: PlayerController
var collided = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		body.spike = self
		player.take_damage_spike()
		collided = true
		$Timer.start(0.5)
	if $Timer.is_stopped():
		collided = false
