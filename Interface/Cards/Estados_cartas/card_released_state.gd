extends CardState


func enter() -> void:
	card_ui.color.color = Color.DARK_MAGENTA
	card_ui.state.text = "RELEASED"
