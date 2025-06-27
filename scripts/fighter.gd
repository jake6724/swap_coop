class_name Fighter
extends CharacterBody2D

@export var fighter_id: int # MUST be set by the multiplayer manager (order of this might need to change)

@onready var input_sychronizer: MultiplayerSynchronizer = $InputSynchronizer

var direction: float
var speed: float = 200

func _ready():
	input_sychronizer.set_multiplayer_authority(fighter_id)

func apply_movement_from_input(delta):
	direction = input_sychronizer.input_direction
	print(direction)
	if direction > 0.0:
		velocity.x = speed
	elif direction < 0.0:
		velocity.x = -speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

func _physics_process(delta):
	if multiplayer.is_server():
		apply_movement_from_input(delta)
