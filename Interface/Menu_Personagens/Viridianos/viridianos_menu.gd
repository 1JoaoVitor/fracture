extends Control
class_name ViridianosMenu

@export var cena_inicial: String

func _input(event):
	if event.is_action_pressed("Esc"): 
		var _chance_scene: bool = get_tree().change_scene_to_file(cena_inicial)

func _ready() -> void: 
	for _button in get_tree().get_nodes_in_group("buttons_viridianos"):
		_button.pressed.connect(_on_button_pressed.bind(_button))
		
func _on_button_pressed(_button : Button) -> void:
	match _button.name:
		"jogar_button": 
			get_tree().change_scene_to_file("res://Interface/Tabuleiro/level.tscn")
		"ant_button": 
			get_tree().change_scene_to_file("res://Interface/Menu_Personagens/Ophidianos/Ophidianos_menu.tscn")
		"prox_button": 
			get_tree().change_scene_to_file("res://Interface/Menu_Personagens/Ophidianos/Ophidianos_menu.tscn")
