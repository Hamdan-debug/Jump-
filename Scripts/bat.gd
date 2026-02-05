extends CharacterBody2D

class_name Bat

@onready var character = $AnimatedSprite2D
@onready var raycast = $AnimatedSprite2D/RayCast2D
@onready var raycast2 = $AnimatedSprite2D/RayCast2D2
@onready var raycast3 = $AnimatedSprite2D/RayCast2D3
@onready var hitbox = $CollisionShape2D
const SPEED = 30
var dir : Vector2 = Vector2.ZERO
@export var player : PlayerController

var collided = false
#States
enum State { CHASE, WANDER }
var current_state = State.WANDER

func _process(delta):
	check_for_player()
	move(delta)
	animation()
func check_for_player():
	# 1. Check if Raycasts see the player right now
	var can_see_player = false
	if raycast.is_colliding() and raycast.get_collider() == Global.player:
		can_see_player = true
	elif raycast2.is_colliding() and raycast2.get_collider() == Global.player:
		can_see_player = true
	elif raycast3.is_colliding() and raycast3.get_collider() == Global.player:
		can_see_player = true

	if can_see_player:
		current_state = State.CHASE
		$Timer.start(10) # Chase for 10 seconds if cant see the leave
	
	# 3. Logic: If the timer runs out, go back to WANDER
	if $Timer.is_stopped():
		current_state = State.WANDER

func move(delta):
	if current_state == State.CHASE:
		if player == null:
			player = Global.player
				
		if player != null:
			dir = position.direction_to(player.position)
			velocity = dir * SPEED
		else:
			velocity = Vector2.ZERO
			
	elif current_state == State.WANDER:
		velocity = Vector2.ZERO
	
	move_and_slide()

func animation():
	if current_state == State.WANDER:
		character.play("idle") 
	elif current_state == State.CHASE:
		character.play("flying")
	
	# Flip sprite based on velocity
	if velocity.x < -0.1:
		character.flip_h = true
	elif velocity.x > 0.1:
		character.flip_h = false

# Clean up the timer function
func _on_timer_timeout():
	pass
	
func _on_hitbox_body_entered(body):
	if (body is PlayerController):
		collided = true
		player.take_damage(global_position)
		$Timer.start(0.5)
	if $Timer.is_stopped():
		collided = false
