class_name FighterForwardGround
extends State

func init_state():
	animation_1 = "forward_ground"

func enter_state():
	player.forward_attack = false

func physics_process_state(_delta):
	player.ap.play(animation_1)

func on_animation_finished(_anim_name):
	transition_state.emit(self, "fighterinactive")