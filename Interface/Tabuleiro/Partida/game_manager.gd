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

		
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# all the game initial state should be initialized here
	pass


# Alterna turnos
func alterar_turno():
	self.turn = self.players[(self.players.find(self.turn) + 1) % 2]
	self.turn.reset_mana()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
