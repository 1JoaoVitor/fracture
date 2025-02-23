extends Control
class_name Slot

var cards : Array[CardUI]
var card_slot = CardSlotSystem.new(self)
@export var allowed_types: Array[String]  #Editable list in the editor for each slot
@onready var collision_shape = $Area2D/CollisionShape2D
@export_enum("Soldado_Top", "General_Top", "Soldado_Down", "General_Down", "Lider") var type_slot: String
enum SlotOwner {PLAYER_1, PLAYER_2}
@export var slot_owner: SlotOwner
@onready var somador = get_parent().get_node("Somador")


func get_inverse():
	var inverse_map = {
		'Slot': 'Slot2',
		'Slot2': 'Slot',
		'Slot3': 'Slot4',
		'Slot4': 'Slot3',
	}
	return self.get_parent().get_node(inverse_map[self.name])

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
