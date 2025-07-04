class_name FighterInactive
extends State

func init_state():
	animation_1 = "idle"

func physics_process_state(_delta):
	player.ap.play(animation_1)

	# These could maybe be called with signals? 
	if player.forward_attack:
		transition_state.emit(self, "fighterforwardground")

	if player.up_attack:
		transition_state.emit(self, "fighterupattack")