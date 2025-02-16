extends Node
class_name GameActions

var gm: GameManager

# Each function corresponds to an action, each one should call the appropriate methods, use mana, etc...

func _init(game_manager: GameManager) -> void:
	self.gm = game_manager

func place_card(card: CardUI, slot: CardSlotSystem):
	if card in self.gm.turn.hand.get_children():
		if self.gm.turn.try_use_mana(card.big_cost, card.small_cost):
			var test = slot.add_card(card)
			print(test)
			#self.gm.return_card_to_player(card) #ainda precisa arrumar
			#var parent = get_parent()
			#if parent.has_method("get_column_type"):
				#column_type = parent.get_column_type()
		else:
			print("Error: Insufficient mana")
			
			return false
	else:
		print("Error: Card not found in hand")
		return false


func use_ability(card: CardUI):
	if card.ability:
		self.gm.turn.try_use_mana(card.big_cost, card.small_cost)
	# verify if the card has an ability and call its function
	
	
func replace_card(new_card: CardUI, slot: CardSlotSystem, old_card: CardUI):
	if new_card in self.gm.turn.hand.get_children():
		if slot.remove_card(old_card):
			if self.gm.turn.try_use_mana(new_card.big_cost, new_card.small_cost):
				self.gm.discard_deck.add_child(old_card)
				slot.add_card(new_card)
				return true
			else:
				print("Error: Insufficient mana")
				return false
		else:
			print("Error: Chosen card is not in the slot")
			return false
	else:
		print("Error: Card not found in hand")
		return false

func buy_extra_card():
	if self.gm.turn.try_use_mana(0, 2):
		if !self.gm.turn.buy_card(): #to do
			print("Error in buy a card") #no card in deck
			return false
		else:
			return true
	else:
		print("Error in buy extra card")
		return false

func change_action(): 
	if !self.gm.turn.change_mana():
		print("Error in change mana")
		return false
	else: 
		return true

func synthesize_cards(card1: CardUI, card2: CardUI): #3 states
	var possible_values = [2, 5, 8]
	if (card1.power.text == "G") or (card2.power.text == "G"):
		print("Error in systhesize cards, card impossible to synthesize")
		return false
		
	if int(card1.power.text) != 2 and int(card2.power.text) != 2:
		print("Error in synthesize cards, no card with power equals 2")
		return false 
	
	if int(card1.power.text) == 2:
		if !int(card2.power.text) in possible_values:
			print("Error in systhesize cards, card impossible to synthesize")
			return false
		else:
			return true
	elif int(card2.power.text) == 2: 
		if !int(card1.power.text) in possible_values: 
			print("Error in systhesize cards, card impossible to synthesize")
		else:
			return true

func pass_turn():
	self.gm.alterar_turno()
	
