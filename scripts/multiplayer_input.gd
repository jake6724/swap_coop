extends MultiplayerSynchronizer

@onready var player = $".." # The parent of InputSynchronizer, either Fighter or Mage
var input_direction: float

func _ready():
	# Only collect input on the client that has authority (don't let host collect for client)
	if get_multiplayer_authority() != multiplayer.get_unique_id():
		set_process(false)
		set_physics_process(false)

	input_direction = Input.get_axis("move_left", "move_right")

func _physics_process(_delta):
	# input_direction is replicated by InpuTSynchronizer so that Host can access
	input_direction = Input.get_axis("move_left", "move_right")

func _process(_delta):
	if Input.is_action_just_pressed("jump"):
		jump.rpc() # Changes made by host will be sent to clients as well

	if Input.is_action_just_pressed("forward_attack_left"):
		forward_attack.rpc()
		input_direction = -1
	
	if Input.is_action_just_pressed("forward_attack_right"):
		forward_attack.rpc()
		input_direction = 1

	if Input.is_action_just_pressed("up_attack"):
		up_attack.rpc()

## This will call on host and client; we only want the host to make updates
@rpc("call_local")
func jump():
	if multiplayer.is_server():
		player.do_jump = true

# It might be tricky, but the is the only way I know to handle passing input to the state machine for now
@rpc("call_local")
func forward_attack():
	if multiplayer.is_server():
		player.forward_attack = true

@rpc("call_local")
func up_attack():
	if multiplayer.is_server():
		player.up_attack = true	