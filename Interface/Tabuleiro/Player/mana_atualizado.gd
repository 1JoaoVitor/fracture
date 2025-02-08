extends Node2D
class_name ManaSystem

var gm : GameManager
var is_scaling_down = false
var is_scaling_up = false
var state_mana: int = 0
var big_mana = 1
var small_mana = 2

@onready var big_mana_UI = $"../BigManaUI"
@onready var small_mana_UI = $"../SmallManaUI"

func _ready():
	for player in self.gm.players:
		player.connect("on_mana_spend", update_mana_display)
		player.connect("on_mana_reset", reset_mana_display)

func _init(game_manager: GameManager):
	self.gm = game_manager

func update_mana_display(big_mana, small_mana):#criar a função para display da mana correto 
	big_mana_UI.visible = big_mana > 0
	small_mana_UI.visible = small_mana > 0
	
func reset_mana_display():#criar a função para display da mana correto 
	big_mana_UI.visible = true
	small_mana_UI.visible = true
	

	
