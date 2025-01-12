extends Control
class_name RegrasMenu

@export var cena_inicial: String

func _input(event):
	if event.is_action_pressed("Esc"): 
		var _chance_scene: bool = get_tree().change_scene_to_file(cena_inicial)
