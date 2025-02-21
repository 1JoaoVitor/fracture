extends Control
class_name MainMenu

func _ready() -> void:


	for _button in get_tree().get_nodes_in_group("buttons"):
		_button.pressed.connect(_on_button_pressed.bind(_button))
		
func _on_button_pressed(_button : Button) -> void:
	var audio = get_node("somfundo")
	# Garantir que o áudio esteja na árvore de nós principal
	if audio.get_parent() != get_tree().root:
		audio.reparent(get_tree().root)  # Move para a raiz da árvore
		audio.owner = null  # Garante que o nó não seja deletado
  
	var sound_player = [$botaosom, $botaosom2, $botaosom3].pick_random()  	# Escolhe aleatoriamente um dos sons
	sound_player.play()
	await sound_player.finished
	
	match _button.name:
		"jogar_button": 
			get_tree().change_scene_to_file("res://Interface/Menu_Personagens/CharacterSelect/character_select_scene.tscn")
		"regras_button": 
			get_tree().change_scene_to_file("res://Interface/Regras/Menu_regras/menu_principal_regras.tscn")
		"configuracao_button":
			get_tree().change_scene_to_file("res://Interface/Configuracao/menu_configuracao.tscn")
		"creditos_button": 
			get_tree().change_scene_to_file("res://Interface/Créditos/creditos.tscn")
		"sair_button": 
			get_tree().quit()
