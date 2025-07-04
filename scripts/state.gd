class_name State
extends Node

var player: Player
var animation_1: String
var animation_2: String
var animation_3: String
signal transition_state

## Called only from parent `state` class. Used for initialization that occurs in EVERY state. State specific init should
## go in `init_state`.
func init_state_universal():
	player.ap.animation_finished.connect(on_animation_finished)

func init_state():
	pass

func enter_state():
	pass

func process_state(_delta):
	pass

func physics_process_state(_delta):
	pass

func exit_state():
	pass

func on_animation_finished(_anim_name):
	pass
