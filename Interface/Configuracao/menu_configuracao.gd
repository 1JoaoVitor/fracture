extends Control
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for _button in get_tree().get_nodes_in_group("button_config"):
		_button.pressed.connect(_on_button_pressed.bind(_button))
	
	$MarginContainer/VBoxContainer/ControleVolume.value = (AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Menu")))
	$MarginContainer/VBoxContainer/ControleVolume2.value = (AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Botoes menu")))
	$MarginContainer/VBoxContainer/ControleVolume3.value = (AudioServer.get_bus_volume_db(AudioServer.get_bus_index("somjogo")))
	
func _process(delta: float) -> void:
	if $MarginContainer/VBoxContainer/ControleVolume.value <= -20:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Menu"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Menu"), false)
	if $MarginContainer/VBoxContainer/ControleVolume2.value <= -20:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Botoes menu"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Botoes menu"), false)
	if $MarginContainer/VBoxContainer/ControleVolume3.value <= -20:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("somjogo"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("somjogo"), false)
	
func _input(event):
	if event.is_action_pressed("Esc"): 
		var _chance_scene: bool = get_tree().change_scene_to_file("res://Interface/Menu/tela_menu.tscn")

func _on_button_pressed(_button : Button) -> void:
	var sound_player = [$botaosom, $botaosom2, $botaosom3].pick_random()  # Escolhe aleatoriamente um dos sons
	sound_player.play()
	await sound_player.finished
	
	match _button.name:
		"sair_button": 
			get_tree().change_scene_to_file("res://Interface/Menu/tela_menu.tscn")


func _on_controle_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Menu"), value)
func _on_controle_volume_2_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Botoes menu"), value)
func _on_controle_volume_3_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("somjogo"), value)
