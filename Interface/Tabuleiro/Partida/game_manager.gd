extends Node
class_name GameManager


var players : Array[Player]
var turn : Player
var buy_deck : Node
var discard_deck : Node
var _game_actions: GameActions
var _mana_system: ManaSystem

func _init(buy_deck: Node, discard_deck: Node) -> void:
	# Inicializar players conforme as informações recebidas no servidor
	if players.size() != 2:
		# esperar ou retornar erro ao criar partida a depender da implementação
		pass
	self.buy_deck = buy_deck
	self.discard_deck = discard_deck
	self.turn = players.pick_random()
	self._game_actions = GameActions.new(self)
	self._mana_system = ManaSystem.new(self)
	_create_cards.call_deferred()


func _create_cards():
	for i in 48:
		var card = CardUI.new_card()
		self.buy_deck.get_parent().add_child(card)
		self.buy_deck.card_slot.add_card(card)


# Alterna turnos
func alterar_turno():
	self.turn = self.players[(self.players.find(self.turn) + 1) % 2]
	self.turn.buy_card() #buy card automatic
	self.turn.reset_mana()
	self.turn.set_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
