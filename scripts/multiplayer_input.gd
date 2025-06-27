extends MultiplayerSynchronizer

var input_direction: float

func _ready():
	# Only collect input on the client that has authority (don't let host collect for client)
	if get_multiplayer_authority() != multiplayer.get_unique_id():
		set_process(false)
		set_process(false)

	input_direction = Input.get_axis("move_left", "move_right")

func _physics_process(delta):
	input_direction = Input.get_axis("move_left", "move_right")

func _process(delta):
	pass