extends Control

signal sum_value_changed

@onready var cor: TextureRect = $Cor
@onready var pontuacao_label: Label = $Cor/Pontos

@export var textura_verde: Texture2D
@export var textura_vermelha: Texture2D

var pontuacao := 2

func _ready():
	pontuacao_label.text = str(pontuacao)
	print("pontuacao_label:", pontuacao_label.text)

func _input(event: InputEvent): #funções para testar se o a mudança de cor está funcionando, pode tirar depois
	if Input.is_action_just_pressed("space"):
		adicionar_pontos(5)
	if Input.is_action_just_pressed("N"):
		adicionar_pontos(-5)


func adicionar_pontos(pontos: int) -> void:
	pontuacao += pontos
	atualizar_pontuacao()
	
func atualizar_pontuacao() -> void:
	pontuacao_label.text = str(pontuacao)
	sum_value_changed.emit()
	_atualizar_cor_circulo()

func _atualizar_cor_circulo() -> void:
	if pontuacao >= 0: # Adicionar uma opção de igual a zero depois
		_trocar_textura(textura_verde)
	else: 
		_trocar_textura(textura_vermelha)
		
func _trocar_textura(nova_textura: Texture2D) -> void:
	if nova_textura != null: 
		cor.texture = nova_textura
	else:
		printerr("Erro, textura invalida")
