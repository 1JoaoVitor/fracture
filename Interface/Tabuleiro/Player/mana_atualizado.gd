extends Control
class_name ManaSystem

var gm : GameManager
var is_scaling_down = false
var is_scaling_up = false
var state_mana: int = 0
var big_mana = 1
var small_mana = 2

@onready var small_mana_1_side_1: Sprite2D = $small_mana1_side1
@onready var small_mana_2_side_1: Sprite2D = $small_mana2_side1
@onready var big_mana_side_1: Sprite2D = $big_mana_side1
@onready var small_mana_1_side_2: Sprite2D = $small_mana1_side2
@onready var small_mana_2_side_2: Sprite2D = $small_mana2_side2
@onready var big_mana_side_2: Sprite2D = $big_mana_side2


func _ready():
	for player in self.gm.players:
		player.connect("on_mana_spend", update_mana_display)
		player.connect("on_mana_reset", reset_mana_display)

func _init(game_manager: GameManager):
	self.gm = game_manager

func update_mana_display(big_mana, small_mana):
	if self.gm.turn == self.gm.player(1):#no caso teria de ver se o player que chamou a função é de baixo ou de cima
		if big_mana < self.big_mana:
			scale_sprite(big_mana_side_1, Vector2(0.02, 0.02), 1.0)
			small_mana_2_side_1.visible = false
		elif self.big_mana == 1 and self.small_mana == 2:
			scale_sprite(small_mana_1_side_1, Vector2(0.01, 0.01), 1.0)
		else:
			scale_sprite(small_mana_2_side_1, Vector2(0.01, 0.01), 1.0)
	else:
		if big_mana < self.big_mana:
			scale_sprite(big_mana_side_2, Vector2(0.02, 0.02), 1.0)
		elif self.big_mana == 1 and self.small_mana == 2:
			scale_sprite(small_mana_1_side_2, Vector2(0.01, 0.01), 1.0)
		else:
			scale_sprite(small_mana_2_side_2, Vector2(0.01, 0.01), 1.0)
	self.big_mana = big_mana
	self.small_mana = small_mana
	
func reset_mana_display():#criar a função para display da mana correto 
	if self.gm.turn == self.gm.player(1):#no caso teria de ver se o player que chamou a função é de baixo ou de cima
		scale_sprite(big_mana_side_1, Vector2(0.265, 0.272), 1.0)
		scale_sprite(small_mana_1_side_1, Vector2(0.133, 0.136), 1.0)
		scale_sprite(small_mana_2_side_1, Vector2(0.133, 0.136), 1.0)
	else:
		scale_sprite(big_mana_side_1, Vector2(0.265, 0.272), 1.0)
		scale_sprite(small_mana_1_side_1, Vector2(0.133, 0.136), 1.0)
		scale_sprite(small_mana_2_side_1, Vector2(0.133, 0.136), 1.0)
	self.big_mana = 1
	self.small_mana = 2


func scale_sprite(sprite: Sprite2D, target_scale: Vector2, duration: float):
	var tween = create_tween()
	tween.tween_property(sprite, "scale", target_scale, duration)
	tween.start()
