extends Node

var client: ClientManager = ClientManager.new()

func _ready() -> void:
	self.client.player = Player.new("Player")


func _process(delta: float) -> void:
	pass
