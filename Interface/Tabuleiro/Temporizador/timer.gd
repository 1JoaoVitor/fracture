extends Control

var time_last: int
var gm: GameManager
var is_visible: bool = false
var is_counting: bool = false
var countdown_accumulator: float = 0.0
@onready var erro_sfx: AudioStreamPlayer = $Erro_sfx
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var timer: Timer = $Timer

func _ready() -> void:
	#GameEvents.timer_reset.connect(reset_timer)
	timer.timeout.connect(_on_timer_timeout)


func set_timer(tempo: int = 30):
	self.gm = get_tree().get_first_node_in_group("game_manager")
	time_last = float(tempo) 
	is_counting = true
	is_visible = true
	self.visible = true
	timer.wait_time = 120
	timer.start()
	texture_progress_bar.max_value = time_last
	texture_progress_bar.value = time_last #seta a barra para 100%

func _process(delta: float) -> void:
	if is_counting:
		time_last = timer.time_left
		texture_progress_bar.value = time_last
		if time_last <= 0:
			is_counting = false
			time_last = 0
			
			#erro_sfx.play()
			
func _on_timer_timeout():  #finalizar o turno automaticamente
	GameEvents.on_end_turn_button_pressed.emit(self.gm.turn.end_turn.bind())

func reset_timer():
	is_counting = false
	texture_progress_bar.max_value = 120
	texture_progress_bar.max_value = 120
	timer.wait_time = 0
	timer.stop()
