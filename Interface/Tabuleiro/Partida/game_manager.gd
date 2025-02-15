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
	for i in 48:
		var card = CardUI.new_card()
		self.buy_deck.get_parent().add_child(card)
		self.buy_deck.card_slot.add_card(card)
	
	var give_cards = func():
		# Lógica para distribuir cartas
		pass
	var timer = Timer.new()


# Alterna turnos
func alterar_turno():
	self.turn = self.players[(self.players.find(self.turn) + 1) % 2]
	self.turn.buy_card() #buy card automatic
	self.turn.reset_mana()
	self.turn.set_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
