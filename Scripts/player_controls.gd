extends CharacterBody2D
class_name PlayerController

@export var speed = 5.0
@export var jump_power = 10
@export var speed_multiplier = 30
@export var jump_multiplier = -30
@export var direction = 0
@export var max_jumps = 2
var jumps_done = 0
var health= 3
var max_health = 3
var times_hit = 0
var player : PlayerController
@export var enemy : Pig
@export var bat: Bat
@export var spike: Spike
var hurt = false
@onready var hurt_timer: Timer = $HurtTimer

@onready var doublejumpdelayer := $doublejumpdelay
@export var double_jump_delay : float = 0.1
@export var healthbar : TextureProgressBar
 
var friction = 10
#const SPEED = 250.0
#const JUMP_VELOCITY = -300.0
func _ready():
	if healthbar != null:
		healthbar.max_value = max_health
		healthbar.value = health
	Global.player = self

func _physics_process(_delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * _delta
	if not hurt:
		if Input.is_action_just_pressed("jump"):
			if is_on_floor():
				velocity.y = jump_power * jump_multiplier
				jumps_done = 1
				
			elif jumps_done < max_jumps:
				velocity.y = jump_power * jump_multiplier
				jumps_done += 1
				
	else:
		velocity.x = move_toward(velocity.x,0,friction)

# Reset jump counter after delay when max jumps reached
	if jumps_done == max_jumps and doublejumpdelayer.is_stopped():
		doublejumpdelayer.start(double_jump_delay)


	if doublejumpdelayer.time_left == 0 and not doublejumpdelayer.is_stopped():
		jumps_done = 0
		print("reset")


	direction = Input.get_axis("move_left", "move_right")

	if direction:
		velocity.x = direction * speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x,0,speed * speed_multiplier)	
	move_and_slide()

	
func knockback(enemy_pos:Vector2):
	# If direction is positive (right), knockback left. Otherwise, knockback right.
	var knock_dir = -1 if direction >= 0 else 1

	velocity.x = knock_dir * 700 
	velocity.y = -200
#Damage func for all characters exept spike
func take_damage(attacker_pos: Vector2):
	if not hurt:
		health -= 1
		if healthbar != null:
			healthbar.value = health
		hurt = true
		hurt_timer.start(0.7)
		knockback(attacker_pos)
		
	if health <= 0:
		get_tree().change_scene_to_file("res://Scenes/retry.tscn")
# Special Damage func for spike
func take_damage_spike():
	if not hurt:
		health -= 1
		healthbar.value -= 1
		hurt = true
		hurt_timer.start(0.7)
		
		# This will now use the position of whichever spike just hit you
	knockback(spike.global_position) 
		
	if health <= 0:
		get_tree().change_scene_to_file("res://Scenes/retry.tscn")

func _on_hurt_timer_timeout() -> void:
	hurt = false
	
