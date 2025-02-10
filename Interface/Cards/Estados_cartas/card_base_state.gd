extends CardState

var is_hovering_card

func enter() -> void:
	if not card_ui.is_node_ready():
		await card_ui.ready
	
	self.is_hovering_card = false
	highlight_card(self.is_hovering_card)
	card_ui.reparent_requested.emit(card_ui)
	card_ui.state.text = "BASE"
	card_ui.color.color = Color.DARK_GREEN
	card_ui.pivot_offset = Vector2.ZERO 
	
func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse_button"):
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
		transition_requested.emit(self, CardState.State.CLICKED)

func on_mouse_entered():
	if !is_hovering_card:
		is_hovering_card = true
		highlight_card(true)
	

func on_mouse_exited():
	is_hovering_card = false 
	highlight_card(false)
	
	
func highlight_card(hovered) -> void:
	if hovered:
		card_ui.scale = Vector2(1.05, 1.05) # aumentar de leve a carta
		card_ui.z_index = 100 #layer da carta
	else:
		card_ui.scale = Vector2(1, 1)
		if card_ui.parent_slot:
			var cards = card_ui.parent_slot.card_slot.cards
			card_ui.z_index = cards.size() - cards.find(card_ui)  # workaround pois o metodo inteiro sera refatorado
		else:
			card_ui.z_index = 1
