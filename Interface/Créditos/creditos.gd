extends Control
class_name CreditosMenu

@export var cena_inicial: String

func _input(event):
	if event.is_action_pressed("Esc"): 
		var _chance_scene: bool = get_tree().change_scene_to_file(cena_inicial)

func _ready() -> void: 
	for _button in get_tree().get_nodes_in_group("button_creditos"):
		_button.pressed.connect(_on_button_pressed.bind(_button))
		
func _on_button_pressed(_button : Button) -> void:
	var sound_player = [$botaosom, $botaosom2, $botaosom3].pick_random()  # Escolhe aleatoriamente um dos sons
	sound_player.play()
	await sound_player.finished
	
	match _button.name:
		"sair_button": 
			get_tree().change_scene_to_file("res://Interface/Menu/tela_menu.tscn")
