extends Node
class_name CardSlotSystem

signal on_card_in
signal on_card_out
var cards : Array[CardUI]
var slot_node : Node2D

func _init(slot_node: Node2D):
	if not slot_node.has_method("get_card_target_position"):
		push_error("get_card_target_position function behavior should be defined")
	self.slot_node = slot_node
	self.cards = []
	print(self.slot_node.name)

func get_card_target_position():
	# param get_position does not receive any params and returns a Vector2D as the card's new position
	return self.slot_node.get_card_target_position()

func get_card_count():
	return self.cards.size()

func add_card(card: CardUI):
	self.cards.append(card)
	card.move_to_position(self.get_card_target_position())
	on_card_in.emit()

func remove_card(card: CardUI):
	# !TODO: Implement
	pass
