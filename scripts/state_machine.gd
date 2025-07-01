class_name StateMachine
extends Node

# Store a hashmap reference to each state 

@export var player: Player
@export var initial_state: State
var current_state: State
var states: Dictionary[String, State] = {}

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

func _process(_delta):
	if multiplayer.is_server():
		if current_state:
			current_state.process_state(_delta)

func _physics_process(_delta):
	if multiplayer.is_server():
		if current_state:
			current_state.physics_process_state(_delta)

func transition(prev_state, new_state):
	if prev_state == current_state:
		prev_state.exit_state()
		if new_state in states:
			current_state = states[new_state] # Used passed statename to look-up state ref 
			current_state.enter_state()

		else:
			push_error(str("State '" + new_state + "' does not exist as state machine child"))
