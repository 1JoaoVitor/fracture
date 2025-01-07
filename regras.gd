extends Control

func _input(event):
	if event.is_action_pressed("Esc"): 
		get_tree().change_scene_to_file("res://Interface/Menu/tela_menu.tscn") 
