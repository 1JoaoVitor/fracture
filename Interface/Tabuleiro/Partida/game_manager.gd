extends Node
class_name GameManager


var players : Array[MatchPlayer]
var turn : MatchPlayer
var buy_deck : Node
var discard_deck : Node
var _game_actions: GameActions
var _mana_system: ManaSystem

func _init(buy_deck: Node, discard_deck: Node, hand: Node, opposite_hand: Node) -> void:
	_init_players(hand, opposite_hand)
	self.buy_deck = buy_deck
	self.discard_deck = discard_deck
	self.turn = players.pick_random()
	self._game_actions = GameActions.new(self)
	self._mana_system = ManaSystem.new(self)

func _ready() -> void:
	_create_cards()

func _init_players(hand: Node, opposite_hand: Node):
	self.players = []
	var mp_players = MultiplayerManager.client.get_players()
	for mpp in mp_players:
		var p: MatchPlayer
		if mpp.nickname == MultiplayerManager.client.get_local_player_nickname():
			p = MatchPlayer.create_from_player(mpp, hand)
		else:
			p = MatchPlayer.create_from_player(mpp, opposite_hand)
		print("%s entered the match!" % p.nickname)
		self.players.append(p)
	
	if players.size() != 2:
		push_error("Not enough players")

func _create_cards():
	var card_types_and_powers = []
	
	var types = ["Jade", "Safira", "Rubi", "Dourado"]
	for type in types:
		for power in range(2, 11): 
			card_types_and_powers.append([type, power])
		card_types_and_powers.append([type, "G"])
			
	card_types_and_powers.shuffle()
	
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
			self.players[0 if alternate else 1].hand.card_slot.add_card(self.buy_deck.card_slot.cards[0])
			alternate = not alternate
			await get_tree().create_timer(0.2).timeout
	var timer = Timer.new()
	(timer.timeout as Signal).connect(deal_cards)
	timer.one_shot = true
	self.add_child(timer)
	timer.start(1.5)
	

# Alterna turnos
func alterar_turno():
	self.turn = self.players[(self.players.find(self.turn) + 1) % 2]
	self.turn.buy_card() #buy card automatic
	self.turn.reset_mana()
	self.turn.set_timer()

func return_card_to_player(card: CardUI):
	self.turn.hand.card_slot.position_cards()

func get_local_player():
	var nickname = MultiplayerManager.client.get_local_player_nickname()
	return self.players[0] if self.players[0].nickname == nickname else self.player[1]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
