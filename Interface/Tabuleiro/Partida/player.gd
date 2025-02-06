extends Node
class_name Player

var nickname : String
var mana : int
var hand : Node

func _init(nickname: String, hand: Node) -> void:
	self.nickname = nickname
	self.hand = hand
	self.mana = 3  # substituir pelo valor padrão da mana

func use_mana(quantity):
	if self.mana - quantity < 0:
		return false
	self.mana -= quantity
	return true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
