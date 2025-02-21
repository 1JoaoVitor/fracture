extends Node
class_name GameActions

var gm: GameManager

# Each function corresponds to an action, each one should call the appropriate methods, use mana, etc...

func _init(game_manager: GameManager) -> void:
	self.gm = game_manager
	GameEvents.on_buy_button_pressed.connect(buy_extra_card)
	GameEvents.on_end_turn_button_pressed.connect(end_turn)
	GameEvents.on_card_placing.connect(place_card)
	GameEvents.on_card_highlighting.connect(highlight_card)
	GameEvents.on_card_dragging.connect(drag_card)

func highlight_card(card: CardUI, callback: Callable):
	if card.parent_slot is Slot or card.parent_slot is Hand:
		callback.call()
		
func drag_card(card: CardUI, callback: Callable):
	if card.parent_slot is Hand:
		callback.call()
	

func place_card(card: CardUI, slot: CardSlotSystem, callback: Callable):
	# checar tipo da coluna/carta
	var parent = slot.slot_node.get_parent()
	var type_slot
	if slot.slot_node is Slot:
		type_slot = slot.slot_node.type_slot
	else:
		type_slot = null
	var column_type
	if parent.has_method("get_column_type"):
		column_type = parent.get_column_type()
	
	# menos performance, mas evita o inferno de if-else's
	var type_rules = [
		card.type == "Soldado" and type_slot in ["Soldado_Top", "Soldado_Down"],
		card.type == "General" and type_slot in ["General_Top", "General_Down"],
		card.type == "Lider" and type_slot == "Lider",
	]
	var rules = [
		(card.type_color == column_type or column_type == "Quartzo"),
		type_rules.reduce(func(a, b): return a or b),
		card in self.gm.turn.hand.card_slot.cards,
		#self.gm.turn.try_use_mana(0, 1),
	]
	if rules.reduce(func(a, b): return a and b):
		if card.type == "Soldado" and (slot.slot_node.type_slot in ["Soldado_Top", "Soldado_Down"]):
			var power = int(card.get_node("Power").text)
			slot.slot_node.somador.adicionar_pontos(power)
		callback.call()
	card.parent_slot.card_slot.position_cards()


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
		
#func buy_card(callback: Callable):
	#if gm.turn == gm.get_local_player():
		#callback.call() 
		
func buy_extra_card(callback: Callable):
	#if gm.turn == gm.get_local_player():
		if !self.gm.turn.try_use_mana(1, 0):
			print("No mana")
		else:
			callback.call() 
	#else:
		#print("Não é você")

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

func end_turn(callback: Callable):
	callback.call()
	#if gm.turn == gm.get_local_player():
		#callback.call()
	#else:
		#print("Não é seu turno!")

	
