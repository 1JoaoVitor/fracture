extends Control

signal sum_value_changed

@onready var cor: TextureRect = $Cor
@onready var pontuacao_label: Label = $Cor/Pontos

@export var textura_verde: Texture2D
@export var textura_vermelha: Texture2D

var pontos_finais = 0

func _ready():
	pontuacao_label.text = str(pontos_finais)
	

func _input(event: InputEvent): #funções para testar se o a mudança de cor está funcionando, pode tirar depois
	if Input.is_action_just_pressed("space"):
		adicionar_pontos(5)
	if Input.is_action_just_pressed("N"):
		adicionar_pontos(-5)


func adicionar_pontos(pontos: int) -> void:
	self.pontos_finais += pontos
	atualizar_pontuacao()
	
func atualizar_pontuacao() -> void:
	pontuacao_label.text = str(pontos_finais)
	sum_value_changed.emit()
	_atualizar_cor_circulo()

func _atualizar_cor_circulo() -> void:
	if pontos_finais >= 0: # Adicionar uma opção de igual a zero depois
		_trocar_textura(textura_verde)
	else: 
		_trocar_textura(textura_vermelha)
		
func _trocar_textura(nova_textura: Texture2D) -> void:
	if nova_textura != null: 
		cor.texture = nova_textura
	else:
		printerr("Erro, textura invalida")
