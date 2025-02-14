extends Node
class_name ClientManager

var player: Player

func get_players() -> Array[Player]:
	var players: Array[Player] = []
	var p1 = self.player
	var p2 = Player.new("Enemy Player")
	if not p1 or not p2:
		push_error("Player 1 not found")
	players.append(p1)
	players.append(p2)
	players.shuffle()  # simular fator em que não se pode confiar na ordem dos players
	return players

func get_local_player_nickname():
	return self.player.nickname

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
