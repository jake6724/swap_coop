class_name FighterUpAttack
extends State

func init_state():
	animation_1 = "up_ground"

func enter_state():
	player.up_attack = false

func physics_process_state(_delta):
	player.ap.play(animation_1)

func on_animation_finished(_anim_name):
	transition_state.emit(self, "fighterinactive")