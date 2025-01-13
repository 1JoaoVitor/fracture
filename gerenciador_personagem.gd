extends Node

var personagem_selecionado: String = ""

func set_personagem(nome_personagem: String):
	personagem_selecionado = nome_personagem
	print("Personagem selecionado:", personagem_selecionado)

func get_personagem() -> String:
	return personagem_selecionado
