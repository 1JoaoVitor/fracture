extends Node2D
class_name LevelMenu

@export var cena_inicial: String
@onready var mana_scene: PackedScene = preload("res://Interface/Tabuleiro/Player/Mana.tscn")# Carrega a cena Mana
@onready var viridianos_mao: Sprite2D = $Telas/Viridianos/Viridianos_mao
@onready var ophidianos_mao: Sprite2D = $Telas/Ophidianos/Ophidianos_mao
@onready var player_hud: CanvasLayer = $Telas/PlayerHUD

@onready var buy_deck = $BattleUI/Compra
@onready var discard_deck = $BattleUI/Descarte
@onready var game_manager: GameManager = GameManager.new(self.buy_deck, self.discard_deck)


func _ready():
	var personagem_escolhido = GerenciadorPersonagem.get_personagem()
	#var personagem_escolhido = GerenciadorPersonagem.get_personagem()  mudar para poder comportar 2 players identicos
	
	match personagem_escolhido:
		"viridiano":
			move_sprite_to_bottom()
		"ophidiano":
			move_sprite_to_top()


func _input(event):
	if event.is_action_pressed("Esc"): 
		var _chance_scene: bool = get_tree().change_scene_to_file(cena_inicial)


func move_sprite_to_bottom():
	# Define a posição para a parte inferior e rotação padrão
	ophidianos_mao.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y - ophidianos_mao.texture.get_height()/2)
	ophidianos_mao.rotation_degrees = 0
	ophidianos_mao.position = Vector2(get_viewport_rect().size.x / 2, ophidianos_mao.texture.get_height()/2)
	ophidianos_mao.rotation_degrees = 180
	ophidianos_mao.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y - ophidianos_mao.texture.get_height()/2)
	ophidianos_mao.rotation_degrees = 0
	ophidianos_mao.position = Vector2(get_viewport_rect().size.x / 2, ophidianos_mao.texture.get_height()/2)
	ophidianos_mao.rotation_degrees = 180
	var tween = create_tween()
	tween.tween_property(ophidianos_mao, "scale",Vector2(0.133, 0.136), 1.0)


func move_sprite_to_top():
	# Define a posição para o topo e rotação de 180 
	viridianos_mao.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y - viridianos_mao.texture.get_height()/2)
	viridianos_mao.rotation_degrees = 0
	viridianos_mao.position = Vector2(get_viewport_rect().size.x / 2, viridianos_mao.texture.get_height()/2)
	viridianos_mao.rotation_degrees = 180
	viridianos_mao.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y - viridianos_mao.texture.get_height()/2)
	viridianos_mao.rotation_degrees = 0
	viridianos_mao.position = Vector2(get_viewport_rect().size.x / 2, viridianos_mao.texture.get_height()/2)
	viridianos_mao.rotation_degrees = 180


func _on_compra_pressed() -> void:
	print('tu comprou uma carta')


func _on_turno_fim_pressed() -> void:
	print('turno passado')


func _on_menu_pressed() -> void:
	print('menu')
