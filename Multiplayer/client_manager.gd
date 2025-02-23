extends Node
class_name ClientManager

const IP_ADDRESS = "127.0.0.1"
const PORT = 50000


signal on_match_start

var player: Player
var current_match: Match


func _ready() -> void:
	if not(OS.has_feature("server") or "--server" in OS.get_cmdline_args()):
		multiplayer.connected_to_server.connect(_on_server_connection)
		GameEvents.on_player_ready.connect(_notify_player_is_ready)
		var peer = ENetMultiplayerPeer.new()
		peer.create_client(IP_ADDRESS, PORT)
		multiplayer.multiplayer_peer = peer


func _on_server_connection():
	print("Unique client id: %s" % multiplayer.get_unique_id())
	self.player = Player.new("Player", multiplayer.get_unique_id())
	player.load_nickname()
	MultiplayerManager.server.join_lobby.rpc_id(1, self.player.to_dict())


func _notify_player_is_ready():
	self.current_match.set_player_as_ready.rpc_id(1)


func get_players() -> Array[Player]:
	self.current_match.request_players.rpc_id(1)
	return await GameEvents.on_players_receive

func get_local_player_nickname():
	return self.player.nickname


func wait_for_match():
	MultiplayerManager.server.find_match.rpc_id(1)
	await self.on_match_start
	

@rpc("authority")
func join_match(match_parent_node_path, m_name):
	var pid = multiplayer.get_unique_id()
	var dummy_match = Match.new(Player.new(), Player.new())
	dummy_match.name = m_name
	get_node(match_parent_node_path).add_child(dummy_match)
	self.current_match = dummy_match
	self.on_match_start.emit()
	

@rpc("authority")
func call_gm(method, args):
	var gm = get_tree().get_first_node_in_group("game_manager") as GameManager
	gm.callv(method, args)
