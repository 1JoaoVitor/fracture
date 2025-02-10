extends Control
class_name Hand

var card_slot = CardSlotSystem.new(self)

func _ready() -> void:
	pass

func get_card_target_position(card: CardUI):
	return self.global_position
