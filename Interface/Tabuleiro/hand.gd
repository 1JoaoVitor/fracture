extends Control
class_name Hand

var card_slot = CardSlotSystem.new(self)

func _ready() -> void:
	pass

func get_card_target_position(card: CardUI):
	var position = self.global_position
	position.x -=  ((self.card_slot.get_card_count() - 1) * card.size.x + 5) / 2
	var offset = card.size.x + 10
	var i = self.card_slot.get_card_index(card)
	position.x += offset * i
	return position

func card_face_up(card):
	card.set_face_card(true)

func card_face_down(card):
	card.set_face_card(false)
