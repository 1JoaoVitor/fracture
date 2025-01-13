extends CardState

var played: bool

func enter() -> void:
	card_ui.color.color = Color.DARK_MAGENTA
	card_ui.state.text = "RELEASED"
	
	played = false
	
	if not card_ui.targets.is_empty():
		played = true
		print("play card for targets: ", card_ui.targets)
		move_to_slot(card_ui.targets[0])

func on_input(_event: InputEvent) -> void:
	if played:
		return
		
	transition_requested.emit(self, CardState.State.BASE)
	
func move_to_slot(slot: Area2D) -> void:
	return
	var target_position = slot.global_position #tem que pegar corretamente a posição do slot desejado!!!
	
	var tween = get_tree().create_tween()
	tween.tween_property(
		card_ui,  # O nó da carta
		"position",  # A propriedade a ser animada
		target_position,  # A posição de destino (local dentro do conjunto de slots)
		0.5  # Duração da animação
	)
