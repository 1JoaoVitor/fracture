extends Resource
class_name CardPile

signal card_pile_size_changed(cards_amount)

@export var cards: Array[Card] = []

func empty() -> void:
	return cards.is_empty()
	
func draw_card() -> Card:
	var card = cards.pop_front()
	card_pile_size_changed.emit(cards.size())
	return card
	
func shuffle() -> void:
	cards.shuffle()
	
func _to_string() -> String: #debug func
	var _card_strings: PackedStringArray = []
	for i in range(cards.size()):
		_card_strings.append("%s: %s" % [i+1, cards[i].id])
	return "\n".join(_card_strings)
