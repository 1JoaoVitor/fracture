extends Player
class_name MatchPlayer

signal on_mana_spend(big_mana, small_mana)
signal on_mana_reset()
signal set_time()
signal use_time()

var big_mana_player : int
var small_mana_player : int
var hand : Hand
var time_left : float
var time_pass : int
var timer_set : bool = false
var gm: GameManager

func _init(nickname: String, hand: Node) -> void:
	self.nickname = nickname
	self.hand = hand
	self.big_mana_player = 1
	self.small_mana_player = 2
	self.time_pass = 7200
	self.time_left = 0

static func create_from_player(player: Player, hand: Node):
	return MatchPlayer.new(player.nickname, hand)

func try_use_mana(big_mana: int, small_mana: int):
	if self.big_mana_player >= big_mana and self.small_mana_player >= small_mana:
		self.big_mana_player -= big_mana
		self.small_mana_player -= small_mana
		on_mana_spend.emit(self.big_mana_player, self.small_mana_player)
		on_mana_spend.emit(self.big_mana_player, self.small_mana_player)
		return true
	else: #aprimorar essa parte
		return false

func set_game_manager(game_manager: GameManager):
	self.gm = game_manager
	return

func reset_mana():
	self.big_mana_player = 1
	self.small_mana_player  = 2
	on_mana_reset.emit()
	
func change_mana():
	if self.try_use_mana(1, 0):
		self.small_mana_player  += 1
		return true
	else:
		return false
		
func set_timer():
	set_time.emit()
	if timer_set == false:
		timer_set = true
	
func buy_card(buy_deck):
	var new_card = buy_deck.card_slot.cards[0] 
	if new_card:
		self.hand.card_slot.add_card(new_card)
		new_card.set_face_card(true)
		print(self.nickname + " comprou a carta " + new_card.name)
		return true
	else:
		print("Erro: sem cartas no baralho!")
		return false

func try_buy_card(buy_deck: Node):
	GameEvents.on_buy_button_pressed.emit(self.buy_card.bind(buy_deck))

func try_end_turn():
	GameEvents.on_end_turn_button_pressed.emit(self.end_turn.bind())

func end_turn():
	gm.end_turn()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
