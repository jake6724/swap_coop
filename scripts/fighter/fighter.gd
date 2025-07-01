class_name Fighter
extends Player

# Child nodes
@onready var ap: AnimationPlayer = $AnimationPlayer

@export var fighter_id :=1:
	set(id):
		fighter_id = id
		%InputSynchronizer.set_multiplayer_authority(id) # Give client authority over InputSynchronizer

# Replicated vars
@export var do_jump: bool = false
@export var direction: float

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var speed: float = 200.0
var jump_velocity: float = 500.0

# Uses the ready function in parent 'player' for now...

func apply_movement_from_input(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta # Change this to have a max later

	# Set x-axis velocity
	direction = %InputSynchronizer.input_direction
	# direction = Input.get_axis("move_left", "move_right")
	if direction > 0.0:
		velocity.x = speed
	elif direction < 0.0:
		velocity.x = -speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	# Jump
	# if do_jump and is_on_floor():
	if do_jump:
		velocity.y = -jump_velocity
		do_jump = false

	move_and_slide()

func _physics_process(delta):
	if multiplayer.is_server():
		apply_movement_from_input(delta)


