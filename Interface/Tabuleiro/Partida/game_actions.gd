extends Node
class_name GameActions

var gm: GameManager

# Each function corresponds to an action, each one should call the appropriate methods, use mana, etc...

func _init(game_manager: GameManager) -> void:
	self.gm = game_manager

func place_card():
	pass
	
func use_ability(card: Card):
	if card.ability:
		self.gm.turn.try_use_mana(card.big_cost, card.small_cost)
	# verify if the card has an ability and call its function
	
	
func replace_card(card: Card, replaced_card: Card):
	pass
	
func buy_extra_card():
	if self.gm.turn.try_use_mana(0, 2):
		if !self.gm.turn.buy_card(): #to do
			print("Error in buy a card") #no card in deck
	else:
		print("Error in buy extra card")

func change_action(): 
	if !self.gm.turn.change_mana():
		print("Error in change mana")

func synthesize_cards(card1: Card, card2: Card): #3 states
	var possible_values = [2, 5, 8]
	if card1.power != 2 and card2.power != 2:
		print("Error in synthesize cards, no card with power equals 2")
		return false 
	
	if card1.power == 2:
		if !(card2.power in possible_values):
			print("Error in systhesize cards, card impossible to synthesize")
			return false
		else:
			return true
	elif card2.power == 2: 
		if !(card1.power in possible_values): 
			print("Error in systhesize cards, card impossible to synthesize")
		else:
			return true


func pass_turn():
	self.gm.alterar_turno()
	
