extends Control
class_name OphidianosMenu

func _input(event):
	if event.is_action_pressed("Esc"): 
		var _chance_scene: bool = get_tree().change_scene_to_file("res://Interface/Menu_Personagens/CharacterSelect/character_select_scene.tscn")

func _ready() -> void: 
	for _button in get_tree().get_nodes_in_group("buttons_ophidianos"):
		_button.pressed.connect(_on_button_pressed.bind(_button))
		
func _on_button_pressed(_button : Button) -> void:
	var sound_player = [$botaosom, $botaosom2, $botaosom3].pick_random()  # Escolhe aleatoriamente um dos sons
	sound_player.play()
	await sound_player.finished
	match _button.name:
		
		"jogar_button":
			GerenciadorPersonagem.set_personagem("ophidiano")
			await MultiplayerManager.client.wait_for_match()
			get_tree().change_scene_to_file("res://Interface/Tabuleiro/level.tscn")
		"ant_button": 
			get_tree().change_scene_to_file("res://Interface/Menu_Personagens/Viridianos/Viridianos_menu.tscn")
		"prox_button": 
			get_tree().change_scene_to_file("res://Interface/Menu_Personagens/Viridianos/Viridianos_menu.tscn")
