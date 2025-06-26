extends Node

var server_ip: String = "127.0.0.1"
var server_port: int = 8080

var fighter_parent: Node2D
var fighter_scene: PackedScene = preload("res://scenes/Fighter.tscn")

func _ready():
	# Get spawn parents
	fighter_parent = get_tree().get_current_scene().get_node("FighterParent")

func become_host() -> int:
	var server_peer: MultiplayerPeer = ENetMultiplayerPeer.new()
	server_peer.create_server(server_port)
	multiplayer.multiplayer_peer = server_peer
	Logger.log("Host server created")
	spawn_player()
	return 0

func join_as_player_2() -> int:
	var client_peer: MultiplayerPeer = ENetMultiplayerPeer.new()
	client_peer.create_client(server_ip, server_port)
	multiplayer.multiplayer_peer = client_peer # IMPORTANT
	Logger.log("Joined as player 2 client")
	spawn_player()
	return 0

func spawn_player():
	var new_fighter = fighter_scene.instantiate()
	fighter_parent.add_child(new_fighter)
	Logger.log("New fighter spwaned")

	

func set_server_ip(new_ip):
	server_ip = new_ip
