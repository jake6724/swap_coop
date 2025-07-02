class_name StateMachine
extends Node

# Store a hashmap reference to each state 

@export var player: Player
@export var initial_state: State
var current_state: State
var current_state_name: String
var states: Dictionary[String, State] = {}

# TODO: This needs to work on client; animations not replicating

func _ready():
	player.player_ready.connect(on_player_ready)

func on_player_ready():
	# Initialize and store all child states
	var children: Array = get_children()
	for s in children:
		states[s.name.to_lower()] = s
		s.player = player
		s.init_state()
		s.transition_state.connect(transition)

	# Configure current state
	print("initial_state: ", initial_state)

	if initial_state:
		current_state = initial_state
	else:
		push_error("initial_state not set; assign in the editor.")

func sync_state(state_name: String):
	current_state_name = state_name
	current_state = states[current_state_name]

func _process(_delta):
	if current_state:
		current_state.process_state(_delta)

func _physics_process(_delta):
	if current_state:
		current_state.physics_process_state(_delta)

func transition(prev_state, new_state):
	if multiplayer.is_server():
		if prev_state == current_state:
			prev_state.exit_state()
			if new_state in states:
				current_state = states[new_state] # Used passed statename to look-up state ref 
				current_state.enter_state()
				# Replicate state name to clients
				sync_state.rpc(new_state)

			else:
				push_error(str("State '" + new_state + "' does not exist as state machine child"))
