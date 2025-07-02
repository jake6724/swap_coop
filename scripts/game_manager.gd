class_name GameManager
extends Node

@export var multiplayer_menu: MultiplayerMenu

func _ready():
	# DEVELOPMENT ONLY - Set which window to play the game
	DisplayServer.window_set_current_screen(1)

	# Connect to multiplayer menu signals
	multiplayer_menu.host_pressed.connect(on_host_pressed)
	multiplayer_menu.join_pressed.connect(on_join_pressed)
	multiplayer_menu.ip_submitted.connect(on_ip_submitted.bind())

func on_host_pressed():
	Logger.log("Host pressed")
	if MultiplayerManager.become_host() == OK:
		multiplayer_menu.hide()

func on_join_pressed():
	Logger.log("Join pressed")
	if MultiplayerManager.join_as_player_2() == OK:
		multiplayer_menu.hide()

func on_ip_submitted(new_ip: String):
	MultiplayerManager.set_server_ip(new_ip)