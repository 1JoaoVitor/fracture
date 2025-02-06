extends CardState

var played: bool

func enter() -> void:
	card_ui.color.color = Color.DARK_MAGENTA
	card_ui.state.text = "RELEASED"
	
	played = false
	
	if not card_ui.targets.is_empty():
		played = true
		print("play card for targets: ", card_ui.targets)
		for t in card_ui.targets:
			t = t.get_parent()
			if "card_slot" in t:
				var slot = t.card_slot as CardSlotSystem
				slot.add_card(card_ui)
				
			

func on_input(_event: InputEvent) -> void:
	if played:
		return
		
	transition_requested.emit(self, CardState.State.BASE)
	
func move_to_slot(slot: Area2D) -> void:
	var new_position = slot.global_position
	# Solução arbitrária com números absolutos, solução relativa é preferível
	new_position.x -= 60
	new_position.y -= 75
	var target_position = new_position
	
	var tween = get_tree().create_tween()
	tween.tween_property(
		card_ui,  # O nó da carta
		"position",  # A propriedade a ser animada
		target_position,  # A posição de destino (local dentro do conjunto de slots)
		0.5  # Duração da animação
	)
