extends Node
class_name GameManager

var players : Array[Player]
var turn : Player
var monte_compra : Node
var monte_descarte : Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Inicializar players conforme as informações recebidas no servidor
	if players.size() != 2:
		# esperar ou retornar erro ao criar partida a depender da implementação
		pass


# Alterna turnos
func _alterar_turno():
	self.turn = self.players[(self.players.find(self.turn) + 1) % 2]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
