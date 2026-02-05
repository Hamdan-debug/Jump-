extends CharacterBody2D

@onready var character = $AnimatedSprite2D
var player : PlayerController
@onready var raycast = $AnimatedSprite2D/RayCast2D
const SPEED = 70
var dir : Vector2

enum State {
	CHASE,
	WANDER
}

var current_state = State.WANDER

func _ready():
	print("Ready")
	
func state():
	if raycast.is_colliding(player):
		current_state = State.CHASE
	else:
		current_state = State.WANDER
func _process(delta):
	move(delta)
	animation()
	
func _on_timer_timeout() -> void:
	$Timer.wait_time = [1.0,1.5,2.0].pick_random()
	if current_state == State.WANDER:
		dir = [Vector2.RIGHT,Vector2.LEFT,Vector2.UP,Vector2.DOWN].pick_random()
		print(dir)
	elif current_state == State.CHASE:
		player = Global.player
		velocity = position.direction_to(player.position) * SPEED
		
func animation():
	if current_state == State.WANDER:
		character.play("idle")
	elif current_state == State.CHASE:
		character.play("flying")
	
	if dir.x == -1:
		character.flip_h = true
	elif dir.x == 1:
		character.flip_h = false
func move(delta):
	if current_state == State.CHASE:
		velocity += dir*SPEED*delta
	else:
		velocity = Vector2.ZERO
	move_and_slide()
