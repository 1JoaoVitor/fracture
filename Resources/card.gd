class_name Card
extends Resource



@export_group ("Card Atributtes")
@export var id: String
@export_enum("Soldado", "General", "Lider") var type: String
@export_enum("Alto", "Medio", "Baixo") var rank: String
@export_enum("Jade", "Safira", "Dourado", "Rubi", "Quartzo") var color: String
