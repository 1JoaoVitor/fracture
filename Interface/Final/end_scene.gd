extends Control
class_name EndScene

func _ready() -> void: 
	for _button in get_tree().get_nodes_in_group("buttons_endscene"):
		_button.pressed.connect(_on_button_pressed.bind(_button))
		
func _on_button_pressed(_button : Button) -> void:
	match _button.name:
		"Return":  
			get_tree().change_scene_to_file("res://Interface/Menu/tela_menu.tscn")
