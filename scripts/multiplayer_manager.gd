extends Node

var server_ip: String = "192.168.191.244"
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
	Logger.log(str("Host created at: " + server_ip + ":" + str(server_port)))
	
	# var a = IP.get_local_addresses()
	# print(a)

	var ip_address :String

	if OS.has_feature("windows"):
		if OS.has_environment("COMPUTERNAME"):
			ip_address =  IP.resolve_hostname(str(OS.get_environment("COMPUTERNAME")),IP.TYPE_IPV4)
	# elif OS.has_feature("x11"):
	# 	if OS.has_environment("HOSTNAME"):
	# 		ip_address =  IP.resolve_hostname(str(OS.get_environment("HOSTNAME")),IP.TYPE_IPV4)
	# elif OS.has_feature("OSX"):
	# 	if OS.has_environment("HOSTNAME"):
	# 		ip_address =  IP.resolve_hostname(str(OS.get_environment("HOSTNAME")),IP.TYPE_IPV4)

	print("ip_address: ", ip_address)

	# Signals
	multiplayer.peer_connected.connect(spawn_player)

	spawn_player(1)

	return 0

func join_as_player_2() -> int:
	var client_peer: MultiplayerPeer = ENetMultiplayerPeer.new()
	client_peer.create_client(server_ip, server_port)
	multiplayer.multiplayer_peer = client_peer # IMPORTANT
	Logger.log("Joined as player 2 client")
	return 0

## This function should be connected to 'multiplayer.peer_connected's callback so as clients are added, players
## are spawned. Host must call this manually, as multiplayer.peer_connected will not trigger for server creation.
func spawn_player(id: int):
	var new_fighter = fighter_scene.instantiate()
	new_fighter.fighter_id = id
	new_fighter.name = str(id)
	fighter_parent.add_child(new_fighter, true)
	Logger.log("New fighter spwaned")

func set_server_ip(new_ip):
	server_ip = new_ip
