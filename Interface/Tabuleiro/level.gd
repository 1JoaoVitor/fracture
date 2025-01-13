extends Node2D
class_name LevelMenu

@export var cena_inicial: String
@onready var spritevirid = $Telas/Viridianos/Viridianos_mao  # Substitua "Sprite" pelo nome do nó da sua sprite.
@onready var spriteophi = $Telas/Ophidianos/Ophidianos_mao  # Substitua "Sprite" pelo nome do nó da sua sprite.
@onready var spritevirid_side = $Telas/Viridianos/Viridianos_side  # Substitua "Sprite" pelo nome do nó da sua sprite.
@onready var spriteophi_side = $Telas/Ophidianos/Ophidianos_side  # Substitua "Sprite" pelo nome do nó da sua sprite.

func _ready():
	var personagem_escolhido = GerenciadorPersonagem.get_personagem()
	
	match personagem_escolhido:
		"viridiano":
			move_sprite_to_top()
		"ophidiano":
			move_sprite_to_bottom()
			

func _input(event):
	if event.is_action_pressed("Esc"): 
		var _chance_scene: bool = get_tree().change_scene_to_file(cena_inicial)
	
	if spritevirid == null:
		print("Erro: O nó 'Viridianos_mao' não foi encontrado!")
		return
		
	if spriteophi == null:
		print("Erro: O nó 'Ophidianos_mao' não foi encontrado!")
		return
		

func move_sprite_to_bottom():
	# Define a posição para a parte inferior e rotação padrão
	spriteophi.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y - spriteophi.texture.get_height()/2)
	spriteophi.rotation_degrees = 0
	spritevirid.position = Vector2(get_viewport_rect().size.x / 2, spritevirid.texture.get_height()/2)
	spritevirid.rotation_degrees = 180
	spriteophi_side.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y - spriteophi_side.texture.get_height()/2)
	spriteophi_side.rotation_degrees = 0
	spritevirid_side.position = Vector2(get_viewport_rect().size.x / 2, spritevirid_side.texture.get_height()/2)
	spritevirid_side.rotation_degrees = 180

func move_sprite_to_top():
	# Define a posição para o topo e rotação de 180 
	spritevirid.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y - spritevirid.texture.get_height()/2)
	spritevirid.rotation_degrees = 0
	spriteophi.position = Vector2(get_viewport_rect().size.x / 2, spriteophi.texture.get_height()/2)
	spriteophi.rotation_degrees = 180
	spritevirid_side.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y - spritevirid_side.texture.get_height()/2)
	spritevirid_side.rotation_degrees = 0
	spriteophi_side.position = Vector2(get_viewport_rect().size.x / 2, spriteophi_side.texture.get_height()/2)
	spriteophi_side.rotation_degrees = 180
