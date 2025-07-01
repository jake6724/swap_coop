class_name FighterIdle
extends State

func init_state():
	animation_1 = "idle"

func physics_process_state(_delta):
	player.ap.play(animation_1)