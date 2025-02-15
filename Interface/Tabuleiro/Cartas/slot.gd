extends Control

var cards : Array[CardUI]
var card_slot = CardSlotSystem.new(self)
@export var allowed_types: Array[String]  #Editable list in the editor for each slot
@onready var collision_shape = $Area2D/CollisionShape2D
@export_enum("Soldado_Top", "General_Top", "Soldado_Down", "General_Down", "Lider") var type_slot: String

func can_place_card(card: CardUI) -> bool:
	return true #isso ta quebrando a maquina de estado aparentemente
	if card.type == "Soldado" and type_slot in ["Soldado_Top", "Soldado_Down"]:
		return true 
	elif card.type == "General" and type_slot in ["General_Top", "General_Down"]:
		return true 
	elif card.type == "Lider" and type_slot == "Lider":
		return true
	else:
		return false


func get_card_target_position(card: CardUI):
	var card_index = self.card_slot.get_card_index(card)
	print(card_index)
	var shape_x = (collision_shape.shape as Shape2D).get_rect().size.x
	var new_position = self.global_position
	new_position.x -= shape_x/2 - card.get_size().x/2
	var offset_x = (shape_x - card.get_size().x) / (2 if self.card_slot.cards.size() <= 3 else self.card_slot.cards.size()-1)
	print(offset_x)
	new_position.x += card_index * offset_x
	return new_position


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
