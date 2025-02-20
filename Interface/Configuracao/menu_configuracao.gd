extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for _button in get_tree().get_nodes_in_group("button_config"):
		_button.pressed.connect(_on_button_pressed.bind(_button))

func _input(event):
	if event.is_action_pressed("Esc"): 
		var _chance_scene: bool = get_tree().change_scene_to_file("res://Interface/Menu/tela_menu.tscn")

func _on_button_pressed(_button : Button) -> void:
	match _button.name:
		"sair_button": 
			get_tree().change_scene_to_file("res://Interface/Menu/tela_menu.tscn")


func _on_controle_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Menu"), value)
	

func _on_controle_volume_2_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Botoes menu"), value)
