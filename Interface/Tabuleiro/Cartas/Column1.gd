extends Node2D

@export var card_texture: Texture  
@export var dark: Vector3 = Vector3(0.7, 0.7 ,0.7)

func _ready():
	var slots = get_children()
	
	for slot in slots:
		if slot.name == "Somador":
			continue

		for child in slot.get_children():
			if child is TextureRect:
				child.texture = card_texture
				child.modulate = Color(dark.x, dark.y, dark.z, 1.0)  
