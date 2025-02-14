extends Node
class_name Player

signal on_mana_spend(big_mana, small_mana)
signal on_mana_reset()
signal set_time()
signal use_time()

var nickname : String
var big_mana : int
var small_mana : int
var hand : Hand
var time_left : float
var time_pass : int
var timer_set : bool = false

func _init(nickname: String, hand: Node) -> void:
	self.nickname = nickname
	self.hand = hand
	self.big_mana = 1
	self.small_mana = 2
	self.time_pass = 7200
	self.time_left = 0

func try_use_mana(big_mana: int, small_mana: int):
	if self.big_mana >= big_mana and self.small_mana >= small_mana:
		self.big_mana -= big_mana
		self.small_mana -= small_mana
		on_mana_spend.emit(self.big_mana, self.small_mana)
		on_mana_spend.emit(self.big_mana, self.small_mana)
		return true
	else: #aprimorar essa parte
		return false

func reset_mana():
	self.big_mana = 1
	self.small_mana = 2
	on_mana_reset.emit()
	
func change_mana():
	if self.try_use_mana(1, 0):
		self.small_mana += 1
		return true
	else:
		return false
		
func set_timer():
	set_time.emit()
	if timer_set == false:
		timer_set = true
	
func buy_card():
	var new_card = self.gm.buy_deck.draw_card()
	if new_card:
		self.hand.add_child(new_card)
		new_card.set_face_card(true)
		print(self.nickname + " comprou a carta " + new_card.name)
		return true
	else:
		print("Erro: sem cartas no baralho!")
		return false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
