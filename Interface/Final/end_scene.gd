extends Control
class_name EndScene

@onready var v_box_container: VBoxContainer = $HBoxContainer/VBoxContainer
@onready var v_box_container_2: VBoxContainer = $HBoxContainer/VBoxContainer2
@onready var v_box_container_3: VBoxContainer = $HBoxContainer/VBoxContainer3
@onready var v_box_container_4: VBoxContainer = $HBoxContainer/VBoxContainer4
@onready var v_box_container_5: VBoxContainer = $HBoxContainer/VBoxContainer5

func _ready() -> void: 
	for _button in get_tree().get_nodes_in_group("buttons_endscene"):
		_button.pressed.connect(_on_button_pressed.bind(_button))
	var v_box = [v_box_container, v_box_container_2, v_box_container_3, v_box_container_4, v_box_container_5]
	var somador
	var resultado
	var i = 0
	var count = 0 
	for v in v_box:
		somador = v.get_child(0)
		resultado = v.get_child(1)
		somador.pontuacao_label.text = str(Valores.somadores_por_coluna[i])
		somador._atualizar_cor_circulo(int(somador.pontuacao_label.text))
		i += 1
		if int(somador.pontuacao_label.text) == 0:
			resultado.text = "Empate"
		elif int(somador.pontuacao_label.text) > 0:
			resultado.text = "Vitoria"
			count += 1
		elif int(somador.pontuacao_label.text) < 0:
			resultado.text = "Derrota"
			count -= 1
			
	var resultado_geral = get_tree().get_first_node_in_group("resultado")
	if count == 0:
		resultado_geral.text = "Empate"
	elif count > 0:
		resultado_geral.text = "Vitória" 
	elif count < 0:
		resultado_geral.text = "Derrota"
		
func _on_button_pressed(_button : Button) -> void:
	match _button.name:
		"Return":  
			get_tree().change_scene_to_file("res://Interface/Menu/tela_menu.tscn")
