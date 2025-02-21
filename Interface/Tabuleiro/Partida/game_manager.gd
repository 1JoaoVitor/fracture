extends Node
class_name GameManager


var players : Array[MatchPlayer]
var turn : MatchPlayer
var buy_deck : Node
var discard_deck : Node
var _game_actions: GameActions
var _mana_system: ManaSystem
var somadores_por_coluna = [0, 0, 0, 0, 0]
var _hand
var _opposite_hand

func _init(buy_deck: Node, discard_deck: Node, hand: Node, opposite_hand: Node) -> void:
	self.buy_deck = buy_deck
	self.discard_deck = discard_deck
	self._game_actions = GameActions.new(self)
	self._mana_system = ManaSystem.new(self)
	self._hand = hand
	self._opposite_hand = opposite_hand


func _ready() -> void:
	await _init_players(self._hand, self._opposite_hand)
	self.turn = players[0]
	GameEvents.on_game_over.connect(end_game)

func _notify_gm_is_ready():
	while self.players == []:
		await get_tree().create_timer(0.25).timeout
	if not self.is_node_ready():
		await self.ready
	GameEvents.on_player_ready.emit()

func _init_players(hand: Node, opposite_hand: Node):
	self.players = []
	var mp_players = await MultiplayerManager.client.get_players()
	for mpp in mp_players:
		var p: MatchPlayer
		if mpp.id == multiplayer.get_unique_id():
			p = MatchPlayer.create_from_player(mpp, hand)
			print("You (%s) entered the match!" % mpp.id)
		else:
			p = MatchPlayer.create_from_player(mpp, opposite_hand)
			print("%s entered the match!" % mpp.id)
		self.players.append(p)
		p.set_game_manager(self)
	
	if players.size() != 2:
		push_error("Not enough players")

func create_cards(card_types_and_powers):
	for i in card_types_and_powers.size():
		var card = CardUI.new_card()
		card.type_color = card_types_and_powers[i][0]
		card.get_node("Power").text = str(card_types_and_powers[i][1])
		if str(card_types_and_powers[i][1]) == "G":
			card.type = "General"
		elif card_types_and_powers[i][1] in [2, 3, 4]:
			card.type = "Soldado"
			card.rank = "Baixo"
		elif card_types_and_powers[i][1] in [5, 6, 7]:
			card.type = "Soldado"
			card.rank = "Medio"
		elif card_types_and_powers[i][1] in [8, 9, 10]:
			card.type = "Soldado"
			card.rank = "Alto"
		self.buy_deck.get_parent().add_child(card)
		self.buy_deck.card_slot.add_card(card)
	
	var deal_cards = func():
		const CARD_QUANTITY_FOR_EACH_PLAYER = 5
		var alternate = false
		for i in CARD_QUANTITY_FOR_EACH_PLAYER * 2:
			var new_card = self.buy_deck.card_slot.cards[0]
			var receiving_player = self.players[0 if alternate else 1] 
			receiving_player.hand.card_slot.add_card(new_card)
			if receiving_player == self.get_local_player():
				receiving_player.hand.card_face_up(new_card)
			
			alternate = not alternate
			await get_tree().create_timer(0.2).timeout
	var timer = Timer.new()
	(timer.timeout as Signal).connect(deal_cards)
	timer.one_shot = true
	self.add_child(timer)
	timer.start(1.5)
	

# Alterna turnos
func end_turn(emit_event=true):
	self.turn = self.players[(self.players.find(self.turn) + 1) % 2]
	print("Turno do jogador: " + turn.nickname)
	self.turn.reset_mana() 
	self.turn.try_buy_card(self.buy_deck, true) #buy card automatic
	self.turn.reset_mana()
	GameEvents.on_mana_reset.emit()
	self.turn.set_timer()
	if emit_event:
		MultiplayerManager.client.current_match.request_end_turn.rpc_id(1)

func return_card_to_player(card: CardUI):
	self.turn.hand.card_slot.position_cards()

func get_local_player():
	return self.players[0] if self.players[0].id == multiplayer.get_unique_id() else self.players[1]


func end_game():
	self.guardar_valores_somadores()
	print("Fim do jogo!")
	#GameData.player_scores = game_manager.get_player_scores() #pegar dados dos somadores
	get_tree().change_scene_to_file("res://Interface/Final/end_scene.tscn")

func guardar_valores_somadores():
	var valores = []
	for coluna in get_tree().get_nodes_in_group("colunas"):
		var somador = coluna.get_node("Somador")
		if somador:
			valores.append(int(somador.pontuacao_label.text))
		else:
			valores.append(0)
			
	Valores.guardar_valores_somadores(valores)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
