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
@onready var mana_player_1: VBoxContainer = $BattleUI/ManaPlayer1
@onready var mana_player_2: VBoxContainer = $BattleUI/ManaPlayer2
@onready var turn_label: Label = $Visual_elements/TurnLabel

@onready var game_manager: GameManager = GameManager.new(
	self.buy_deck,
	self.discard_deck,
	self.hand,
	self.opposite_hand,
)

func _ready():
	turn_label.visible = false
	self.add_child(self.game_manager)
	game_manager.add_to_group("game_manager")
	game_manager._notify_gm_is_ready()
	var personagem_escolhido = GerenciadorPersonagem.get_personagem()
	GameEvents.on_mana_spend.connect(update_mana_visual)
	GameEvents.on_mana_reset.connect(reset_mana_visual)
	GameEvents.new_turn.connect(show_turn_notification)
	GameEvents.match_started.connect(show_turn_notification)

	
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
	game_manager.turn.try_end_turn()


func _on_menu_pressed() -> void:
	print('menu')
	
	
func update_mana_visual(player, small_mana_count, big_mana_available):
	var mana_container
	if player == game_manager.get_local_player():
		mana_container = mana_player_1
	else:
		mana_container = mana_player_2
	# Atualiza as manas pequenas (2 manas no VBox)
	
	for i in range(2):  
		var mana_small = mana_container.get_child(i)
		print("Atualizando mana pequena", i, "Visível?", i < small_mana_count)
		mana_small.visible = i < small_mana_count  
		
	# Atualiza a mana grande (última mana do VBox)
	var mana_big = mana_container.get_child(mana_container.get_child_count() - 1)
	print("Atualizando mana grande. Visível?", big_mana_available)
	mana_big.visible = big_mana_available

func reset_mana_visual():
	update_mana_visual(game_manager.players[0], 2, true)
	update_mana_visual(game_manager.players[1], 2, true)

func show_turn_notification():
	turn_label.text = "Seu turno!"
	turn_label.visible = true
	await get_tree().create_timer(2.5).timeout 
	turn_label.visible = false
