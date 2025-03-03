extends Node
class_name Match


var players: Array[Player]
var n_players_ready: int = 0


func _init(p1: Player, p2: Player) -> void:
	self.players.append(p1)
	self.players.append(p2)
	self.players.shuffle()
	GameEvents.on_card_added.connect(_notify_card_added)
	GameEvents.on_points_updated.connect(_notify_points_updated)
	GameEvents.on_game_over.connect(_notify_game_over)




@rpc("any_peer")
func set_player_as_ready():
	self.n_players_ready += 1
	if self.n_players_ready == 2:
		start_match()
	

func start_match():
	print("All players are ready, starting match...")
	_generate_initial_deck()
	


func _generate_initial_deck():
	var card_types_and_powers = []	
	var types = ["Jade", "Safira", "Rubi", "Dourado"]
	for type in types:
		for power in range(2, 11): 
			card_types_and_powers.append([type, power])
		card_types_and_powers.append([type, "G"])
	card_types_and_powers.shuffle()
	for p in players:
		MultiplayerManager.client.call_gm.rpc_id(p.id, 'create_cards', [card_types_and_powers])


func _notify_card_added(card_index: int, origin: Node, target: Node):	
	if origin.has_method('get_inverse'):
		origin = origin.get_inverse()
	if target.has_method('get_inverse'):
		target = target.get_inverse()
	_sync_card_added.rpc_id(1, card_index, origin.get_path(), target.get_path())

@rpc("any_peer")
func _sync_card_added(card_index, origin_path, target_path):
	var spid = multiplayer.get_remote_sender_id()
	var tpid = players[1].id if players[0].id == spid else players[0].id
	_do_sync_card_added.rpc_id(tpid, card_index, origin_path, target_path)
	
@rpc("authority")
func _do_sync_card_added(card_index, origin_path, target_path):
	var origin = get_tree().root.get_node(origin_path)
	var target = get_tree().root.get_node(target_path)
	var card = origin.card_slot.cards[card_index]
	target.card_slot.add_card(card, false)
	card.set_face_card(true)
	
	
func _notify_points_updated(somador: Node, new_points: int):
	#if somador.get_parent().has_method('get_inverse'):
		#somador = somador.get_parent().get_inverse().get_node("Somador")
	_sync_points_updated.rpc_id(1, somador.get_path(), new_points)

@rpc("any_peer")
func _sync_points_updated(somador_path, new_points):
	var spid = multiplayer.get_remote_sender_id()
	var tpid = players[1].id if players[0].id == spid else players[0].id
	_do_sync_points_updated.rpc_id(tpid, somador_path, new_points)


@rpc("authority")
func _do_sync_points_updated(somador_path, new_points):
	var somador = get_tree().root.get_node(somador_path)
	somador.pontuacao = -new_points
	somador.atualizar_pontuacao()
	somador._atualizar_cor_circulo(somador.pontuacao)
	#column.update_visual()  # Atualiza a interface

	
func _notify_game_over():
	_sync_game_over.rpc_id(1)
	
@rpc("any_peer")
func _sync_game_over():
	var spid = multiplayer.get_remote_sender_id()
	var tpid = players[1].id if players[0].id == spid else players[0].id
	MultiplayerManager.client.call_gm.rpc_id(tpid, "guardar_valores_somadores", [])
	_do_sync_game_over.rpc_id(tpid)
	
@rpc("authority")
func _do_sync_game_over():
	get_tree().change_scene_to_file("res://Interface/Final/end_scene.tscn")

	
@rpc("any_peer")
func request_players():
	var pid = multiplayer.get_remote_sender_id()
	receive_players.rpc_id(pid, [
		self.players[0].to_dict(),
		self.players[1].to_dict(),
	])
	
@rpc("any_peer")
func request_end_turn():
	var spid = multiplayer.get_remote_sender_id()
	var tpid = players[1].id if players[0].id == spid else players[0].id
	MultiplayerManager.client.call_gm.rpc_id(tpid, "end_turn", [false])

@rpc("authority")
func receive_players(players_dict):
	var players = [
		Player.from_dict(players_dict[0]),
		Player.from_dict(players_dict[1])
	] as Array[Player]
	GameEvents.on_players_receive.emit(players)
	
	
