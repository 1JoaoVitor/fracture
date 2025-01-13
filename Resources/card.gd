class_name Card
extends Resource

enum Type {SOLDADO, GENERAL, LIDER}
enum Target {SOLDADO_SLOT, GENERAL_SLOT, LIDER_SLOT}

@export_group ("Card Atributtes")
@export var id: String
@export var type: Type
@export var target: Target

func is_soldado() -> bool:
	return type == Type.SOLDADO
