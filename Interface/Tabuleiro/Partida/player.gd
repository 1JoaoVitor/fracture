extends Node
class_name Player

var nome : String
var mana : int
var mao : Node

func _init(nome: String, mao: Node) -> void:
	self.nome = nome
	self.mao = mao
	self.mana = 3  # substituir pelo valor padrão da mana

func gastar_mana(quantidade):
	if self.mana - quantidade:
		return
	self.mana -= quantidade

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
