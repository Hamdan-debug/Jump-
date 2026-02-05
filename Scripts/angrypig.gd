extends CharacterBody2D
class_name Pig


@export var player: PlayerController
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast : RayCast2D = $AnimatedSprite2D/RayCast2D
@onready var timer : Timer = $Timer
@export var Speed : int = 50
@export var acceleration: int = 300
@export var chasespeed: int = 100
@onready var player_controller : PlayerController
var initial_speed = 40
var wander_acceleration = 30

var collided = false

var right_bounds : Vector2
var left_bounds : Vector2
var direction: Vector2
var current_state = States.Wander

enum States{
	Wander,
	Chase
}
# Called functions required 
func _ready() -> void:
	left_bounds = self.position + Vector2(-50,0)
	right_bounds = self.position + Vector2(50,0)
	direction = Vector2.LEFT
	timer.timeout.connect(_on_timer_timeout)


func _process(delta: float) -> void:
	look_for_Player()
	handle_movement(delta)
	handle_gravity(delta)
	change_direction()
	move_and_slide()	
	

func look_for_Player():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider == player:
			chase_player()
		elif current_state == States.Chase:
			stop_chase()
			
func stop_chase():
	$Timer.stop()
	current_state = States.Wander
	sprite.animation = "idle"
		

func chase_player():
	current_state = States.Chase
	$Timer.start()
	sprite.animation = "chase"
	
		
func handle_movement(delta):
	if current_state == States.Wander:
		velocity = velocity.move_toward(direction * initial_speed, wander_acceleration* delta)
	else:
		velocity = velocity.move_toward(direction * chasespeed, acceleration* delta)

func change_direction() -> void:
	if current_state == States.Wander:
		if direction.x > 0: # Moving Right
			if position.x >= right_bounds.x:
				direction = Vector2.LEFT
				sprite.flip_h = false
		else: # Moving Left
			if position.x <= left_bounds.x:
				direction = Vector2.RIGHT
				sprite.flip_h = true
	else:
		# Chase logic
		var dir_to_player = (player.position - self.position).normalized()
		direction.x = sign(dir_to_player.x)
		sprite.flip_h = (direction.x > 0)


	raycast.target_position.x = direction.x * 125
		

func handle_gravity(delta: float)-> void:
	if not is_on_floor():
		velocity.y += 980 * delta

func  _on_timer_timeout():
	current_state = States.Wander
func _on_hitbox_body_entered(body):
	if (body is PlayerController):
		collided = true
		player.take_damage(global_position)
		$Timer.start(0.5)
		
	if $Timer.is_stopped():
		collided = false
	
