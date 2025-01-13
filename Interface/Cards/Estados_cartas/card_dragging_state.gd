extends CardState

const DRAG_MINIMUM_THRESHOLD := 0.05 
#variaveis para arrumar problema de soltar a carta muito rapidamente
var minimum_drag_time_elapsed := false

func enter() -> void:
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")# arrumar isso quando fizer o tabuleiro, video 2 minuto 29 do tutorial
	if ui_layer:
		card_ui.reparent(ui_layer)
		
	card_ui.color.color = Color.NAVY_BLUE
	card_ui.state.text = "DRAGGING"
	card_ui.scale = Vector2(1, 1)
	
	minimum_drag_time_elapsed = false 
	var threshold_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	threshold_timer.timeout.connect(func(): minimum_drag_time_elapsed = true)
	
func on_input(event: InputEvent) -> void:
	var mouse_motion := event is InputEventMouseMotion #flag pra mouse motion
	var cancel = event.is_action_pressed("right_mouse_button") #flag para cancelar o arraste da carta
	var confirm = event.is_action_pressed("left_mouse_button") or event.is_action_released("left_mouse_button") #flag para confirmar 
	
	if mouse_motion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
	if cancel: 
		card_ui.scale = Vector2(1.05, 1.05)
		transition_requested.emit(self, CardState.State.BASE)
	elif minimum_drag_time_elapsed and confirm:
		card_ui.scale = Vector2(1.05, 1.05)
		get_viewport().set_input_as_handled() #input tratado/manipulada, evitar pegar outra carta
		transition_requested.emit(self, CardState.State.RELEASED)
