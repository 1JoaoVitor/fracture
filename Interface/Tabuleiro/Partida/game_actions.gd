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
		
	# Garantir que o jogador só pode jogar nos seus próprios slots
	var current_player = self.gm.turn  
	var allowed_slots = []
	if current_player == self.gm.get_local_player():  # Player 1
		allowed_slots = ["Soldado_Down", "General_Down"]
	else:  # Player 2
		allowed_slots = ["Soldado_Top", "General_Top"]
	
	var is_valid_combination = false
	var custo_big_mana = 0
	var custo_small_mana = 0
	
	if card.type == "Soldado": 
		var existing_cards = slot.cards  # Pega as cartas já no slot
		var current_ranks = [] 
		
		for c in existing_cards:
			current_ranks.append(c.rank)  
			
		current_ranks.append(card.rank)  
		
		current_ranks.sort()
		
		if card.rank == "Alto":
			if current_ranks == ["Alto"]:
				is_valid_combination = true
			elif current_ranks == ["Alto", "Baixo"]:
				is_valid_combination = true
			custo_big_mana = 1
			
		elif card.rank == "Medio":
			if current_ranks == ["Medio"]:
				is_valid_combination = true
			elif current_ranks == ["Medio", "Medio"]:
				is_valid_combination = true
			elif current_ranks == ["Baixo", "Medio"]:
				is_valid_combination = true
			elif current_ranks == ["Baixo", "Baixo","Medio"]:
				is_valid_combination = true
			custo_big_mana = 1
			
		elif card.rank == "Baixo":
			if current_ranks == ["Baixo"]:
				is_valid_combination = true
				custo_small_mana = 1
			elif current_ranks == ["Alto", "Baixo"]:
				is_valid_combination = true
				custo_big_mana = 1
			elif current_ranks == ["Baixo", "Medio"]:
				is_valid_combination = true
				custo_small_mana = 1
			elif current_ranks == ["Baixo", "Baixo"]:
				is_valid_combination = true
				custo_small_mana = 1
			elif current_ranks == ["Baixo", "Baixo","Medio"]:
				is_valid_combination = true
				custo_small_mana = 1
			
	else:
		custo_small_mana = 1
		is_valid_combination = true
	print("Custo big mana: ", custo_big_mana)
	print("Custo small mana: ", custo_small_mana)
		
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
		type_slot in allowed_slots,
		is_valid_combination,
	]
	# Imprimir as regras
	print("Player small mana: ", self.gm.turn.small_mana_player)
	print("Player big mana: ", self.gm.turn.big_mana_player)
	var can_use_mana = false
	if rules.reduce(func(a, b): return a and b):
		can_use_mana = self.gm.turn.try_use_mana(custo_big_mana, custo_small_mana)
	
	print("Depois Player small mana: ", self.gm.turn.small_mana_player)
	print("Depois Player big	 mana: ", self.gm.turn.big_mana_player)
	
	if can_use_mana:
		GameEvents.on_mana_spend.emit(self.gm.turn, self.gm.turn.small_mana_player, self.gm.turn.big_mana_player > 0)
		if card.type == "Soldado" and (slot.slot_node.type_slot in ["Soldado_Top", "Soldado_Down"]):
			var power = int(card.get_node("Power").text)
			if current_player == self.gm.get_local_player():
				slot.slot_node.somador.adicionar_pontos(power)
			else:
				slot.slot_node.somador.adicionar_pontos(-power)
		if card.type == "General" and (slot.slot_node.type_slot in ["General_Top", "General_Down"]):
				if current_player == self.gm.get_local_player():
					slot.slot_node.somador.adicionar_pontos(1)
				else:
					slot.slot_node.somador.adicionar_pontos(-1)
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
		if !self.gm.turn.try_use_mana(0, 2):
			print("No mana")
		else:			
			GameEvents.on_mana_spend.emit(self.gm.turn, self.gm.turn.small_mana_player, self.gm.turn.big_mana_player > 0)
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
	if gm.buy_deck.card_slot.cards.is_empty():
		print("Baralho vazio!")
		#if gm.turn == gm.players[-1]: 
		print("Último turno encerrado, fim do jogo!")
		GameEvents.on_game_over.emit()
	else:
		callback.call()
	#if gm.turn == gm.get_local_player():
		#callback.call()
	#else:
		#print("Não é seu turno!")
