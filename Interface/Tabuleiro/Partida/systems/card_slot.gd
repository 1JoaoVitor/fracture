extends Node
class_name CardSlotSystem

signal on_card_in
signal on_card_out
var cards : Array[CardUI]
var slot_node : Control
var gm: GameManager

func _init(slot_node: Control):
	if not slot_node.has_method("get_card_target_position"):
		push_error("get_card_func add_card(card: CardUI):
target_position function behavior should be defined")
	self.slot_node = slot_node
	self.cards = []
	

func get_card_target_position(card: CardUI):
	# param get_position does not receive any params and returns a Vector2D as the card's new position
	return self.slot_node.get_card_target_position(card)


func get_card_count():
	return self.cards.size()


func get_card_index(card: CardUI):
	return self.cards.find(card)


func add_card(card: CardUI, sync=true):
	var card_index = -1
	var card_parent_slot = card.parent_slot
	if card.parent_slot != null:
		card_index = card_parent_slot.card_slot.cards.find(card)
		card.parent_slot.card_slot.remove_card(card)
	if sync:
		GameEvents.on_card_added.emit(card_index, card_parent_slot, self.slot_node)
	self.cards.append(card)
	card.parent_slot = self.slot_node
	
	position_cards()
	
func try_add_card(card: CardUI):
	GameEvents.on_card_placing.emit(card, self, func(): add_card(card))


func position_cards():
	for i in self.cards.size():
		var card = self.cards[i]
		card.z_index = self.cards.size() - i
		card.move_to_position(self.slot_node.get_card_target_position(card))


func remove_card(card: CardUI):
	if card in self.cards:
		self.cards.erase(card)
		position_cards()
		self.on_card_out.emit()
