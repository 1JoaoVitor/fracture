extends Node
class_name GameActions

var gm: GameManager

# Each function corresponds to an action, each one should call the appropriate methods, use mana, etc...

func _init(game_manager: GameManager) -> void:
	self.gm = game_manager

func place_card():
	pass
	
func use_ability(card: Card):
	# verify if the card has an ability and call its function
	pass
	
func replace_card(card: Card, replaced_card: Card):
	pass
	
func buy_extra_card():
	pass

func change_action():  # still exists?
	pass
	
func synthesize_cards(card1: Card, card2: Card):
	pass

func pass_turn():
	pass
