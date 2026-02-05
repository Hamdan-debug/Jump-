extends Node2D
@export  var  player_controls: PlayerController
@export var animation_player :AnimationPlayer 
@export var sprite : Sprite2D



func _process(delta):
	if player_controls.direction == 1:
		sprite.flip_h = false
	elif player_controls.direction == -1:
		sprite.flip_h = true
	
	if abs(player_controls.velocity.x) > 0.0:
		animation_player.play("run")
	else:
		animation_player.play("Idle") 
		
	if player_controls.velocity.y < 0.0 and player_controls.jumps_done == 1:
		animation_player.play("jump")
	elif player_controls.velocity.y < 0.0 and player_controls.jumps_done == 2:
		animation_player.play("double_jump")
	elif player_controls.velocity.y > 0.0:
		animation_player.play("fall")

  
