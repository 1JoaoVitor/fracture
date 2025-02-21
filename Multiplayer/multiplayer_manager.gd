extends Node

var client: ClientManager
var server: ServerManager

func _ready() -> void:
	print("Starting multiplayer...")
	self.server = ServerManager.new()
	self.add_child(self.server)
	self.client = ClientManager.new()
	self.add_child(self.client)
	
	
func _on_peer_connected(id):
	if multiplayer.is_server():
		return
	

func _process(delta: float) -> void:
	pass
