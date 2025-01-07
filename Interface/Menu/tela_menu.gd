extends Control
class_name MainMenu

func _ready() -> void: 
	for _button in get_tree().get_nodes_in_group("buttons"):
		_button.pressed.connect(_on_button_pressed.bind(_button))
		
func _on_button_pressed(_button : Button) -> void:
	match _button.name:
		"jogar_button": 
			get_tree().change_scene_to_file("res://level.tscn")
		"regras_button": 
			get_tree().change_scene_to_file("res://regras.tscn")
		"creditos_button": 
			get_tree().change_scene_to_file("res://creditos.tscn")
		"sair_button": 
			get_tree().quit()
