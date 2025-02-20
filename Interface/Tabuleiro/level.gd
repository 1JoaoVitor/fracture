extends Node2D
class_name LevelMenu

@export var cena_inicial: String
@onready var mana_scene: PackedScene = preload("res://Interface/Tabuleiro/Player/Mana.tscn")# Carrega a cena Mana
@onready var viridianos_mao: Sprite2D = $Telas/Viridianos/Viridianos_mao
@onready var ophidianos_mao: Sprite2D = $Telas/Ophidianos/Ophidianos_mao
@onready var viridianos_mao_side_2: Sprite2D = $Telas/Viridianos/Viridianos_mao_side2
@onready var ophidianos_mao_side_2: Sprite2D = $Telas/Ophidianos/Ophidianos_mao_side2
@onready var player_hud: CanvasLayer = $Telas/PlayerHUD
@onready var buy_deck = $BattleUI/BuyDeck
@onready var discard_deck = $BattleUI/DiscardDeck
@onready var hand = $BattleUI/Hand
@onready var opposite_hand = $BattleUI/OppositeHand

@onready var game_manager: GameManager = GameManager.new(
	self.buy_deck,
	self.discard_deck,
	self.hand,
	self.opposite_hand,
)


func _ready():
	self.add_child(self.game_manager)
	var personagem_escolhido = GerenciadorPersonagem.get_personagem()
	
	#var personagem_escolhido = GerenciadorPersonagem.get_personagem()  mudar para poder comportar 2 players identicos
	
	match personagem_escolhido:
		"viridiano":
			viridianos_mao_side_2.visible = false
			ophidianos_mao.visible = false
		"ophidiano":
			viridianos_mao.visible = false
			ophidianos_mao_side_2.visible = false
	
	#for i in range(6):
		#if i == 0 || i == 3:
			#Estado.set_state_possition(1,6-i)
		#else:
			#Estado.set_state_possition(2,6-i)
		#var mana_instance = mana_scene.instantiate()
		#player_hud.add_child(mana_instance)
		#if i < 3:
			#mana_instance.position = Vector2(520 - (i * 100), 1000)
		#else:
			#mana_instance.position = Vector2(520 - ((i-3) * 100), 75)


func _input(event):
	if event.is_action_pressed("Esc"): 
		var _chance_scene: bool = get_tree().change_scene_to_file(cena_inicial)


func _on_compra_pressed() -> void:
	game_manager.turn.try_buy_card(game_manager.buy_deck)

	


func _on_turno_fim_pressed() -> void:
	print('turno passado')


func _on_menu_pressed() -> void:
	print('menu')
