extends MultiplayerSynchronizer

@onready var player = $".." # The parent of InputSynchronizer, either Fighter or Mage
var input_direction: float

func _ready():
	# Only collect input on the client that has authority (don't let host collect for client)
	if get_multiplayer_authority() != multiplayer.get_unique_id():
		set_process(false)
		set_process(false)

	input_direction = Input.get_axis("move_left", "move_right")

func _physics_process(_delta):
	# input_direction is replicated by InpuTSynchronizer so that Host can access
	input_direction = Input.get_axis("move_left", "move_right")

func _process(_delta):
	if Input.is_action_just_pressed("jump"):
		jump.rpc() # Changes made by host will be sent to clients as well

## This will call on host and client; we only want the host to make updates
@rpc("call_local")
func jump():
	if multiplayer.is_server():
		player.do_jump = true
		