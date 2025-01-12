extends CardState

func enter() -> void:
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")# arrumar isso quando fizer o tabuleiro, video 2 minuto 29 do tutorial
	if ui_layer:
		card_ui.reparent(ui_layer)
		
	card_ui.color.color = Color.NAVY_BLUE
	card_ui.state.text = "DRAGGING"
	
func on_input(event: InputEvent) -> void:
	var mouse_motion := event is InputEventMouseMotion #flag pra mouse motion
	var cancel = event.is_action_pressed("right_mouse_button") #flag para cancelar o arraste da carta
	var confirm = event.is_action_pressed("left_mouse_button") or event.is_action_released("left_mouse_button") #flag para confirmar 
	
	if mouse_motion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
	if cancel: 
		transition_requested.emit(self, CardState.State.BASE)
	elif confirm:
		get_viewport().set_input_as_handled() #input tratado/manipulada, evitar pegar outra carta
		transition_requested.emit(self, CardState.State.RELEASED)
