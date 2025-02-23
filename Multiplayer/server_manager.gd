extends Node
class_name ServerManager

const PORT = 50000
const MAX_CLIENTS = 10

var matches: Dictionary = {}
var lobby: Dictionary = {}
var waiting_for_match: Player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OS.has_feature("server") or "--server" in OS.get_cmdline_args():
		print("starting server")
		var peer = ENetMultiplayerPeer.new()
		peer.create_server(PORT, MAX_CLIENTS)
		multiplayer.multiplayer_peer = peer
		print("Server started")


@rpc("any_peer")
func join_lobby(player_info: Dictionary):
	var pid = multiplayer.get_remote_sender_id()
	var player = Player.from_dict(player_info)
	print("Player with name ", player.nickname, " and pid ", player.id, " joined the lobby.")
	lobby[pid] = player

@rpc("any_peer")
func find_match():
	var pid: int = multiplayer.get_remote_sender_id()
	if self.waiting_for_match == null:
		self.waiting_for_match = lobby[pid]
		return
	if self.waiting_for_match.id == pid:
		return
	var wpid = self.waiting_for_match.id
	self.waiting_for_match = null
	var m = Match.new(lobby[pid], lobby[wpid])
	self.matches[pid] = m
	var i1 = pid
	var i2 = wpid
	if i1 > i2:
		i1 = wpid
		i2 = pid
	m.name = str(i1) + '__' + str(i2)
	self.add_child(m)
	MultiplayerManager.client.join_match.rpc_id(pid, m.get_parent().get_path(), m.name)
	MultiplayerManager.client.join_match.rpc_id(wpid, m.get_parent().get_path(), m.name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
