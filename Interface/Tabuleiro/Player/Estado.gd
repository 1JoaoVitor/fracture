extends Node

var estado_recebido: int
var possicao_recebida: int


func set_state_possition(estado_pasado: int,possicao_passada: int):
	estado_recebido = estado_pasado
	possicao_recebida = possicao_passada
	print("estado recebido:", estado_recebido)
	print("posição recebida:", possicao_recebida)


func get_state() -> int:
	return estado_recebido


func get_position() -> int:
	return possicao_recebida
