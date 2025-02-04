extends Control

func _ready() -> void: 
	for _button in get_tree().get_nodes_in_group("botoes_menu_regras"):
		_button.pressed.connect(_on_button_pressed.bind(_button))
		
func _input(event):
	if event.is_action_pressed("Esc"): 
		var _chance_scene: bool = get_tree().change_scene_to_file("res://Interface/Menu/tela_menu.tscn")
		
func _on_button_pressed(_button : Button) -> void:
	match _button.name:
		"Introducao": 
			get_tree().change_scene_to_file("res://Interface/Regras/Menu_regras/menu_principal_regras.tscn")
		"Tabuleiro": 
			get_tree().change_scene_to_file("res://Interface/Regras/Menu_regras/menu_tabuleiro_regras.tscn")
		"Tipo_carta": 
			get_tree().change_scene_to_file("res://Interface/Regras/Menu_regras/menu_tiposCarta_regras.tscn")
		"Dinamica_jogo": 
			get_tree().change_scene_to_file("res://Interface/Regras/Menu_regras/menu_dinamica.tscn")
		"Habilidades": 
			get_tree().change_scene_to_file("res://Interface/Regras/Menu_regras/menu_habilidades_cartas.tscn")
		"batalha_final": 
			get_tree().change_scene_to_file("res://Interface/Regras/Menu_regras/menu_batalha_final.tscn")
		"Sair":
			get_tree().change_scene_to_file("res://Interface/Menu/tela_menu.tscn")
