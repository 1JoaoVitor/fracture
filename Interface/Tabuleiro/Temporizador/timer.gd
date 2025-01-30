extends Control

var time_last: int = 7200  # Tempo inicial para a contagem regressiva
var is_visible: bool = false  # Controla se o objeto está visível
var pass_time: float = 0.0  # Tempo acumulado para esperar os 5 segundos
var countdown_accumulator: float = 0.0  # Acumulador para a contagem regressiva
@onready var erro_sfx: AudioStreamPlayer = $Erro_sfx


func _ready() -> void:
	hide()


func action():
	
	time_last += 600
	if time_last > 7200:
		pass_time -= (time_last-7200)/120
		time_last = 7200
		is_visible = false
		hide()


func _process(delta: float) -> void:
	
	if not is_visible:
		pass_time += delta
		if pass_time >= 5.0:
			show()
			is_visible = true
	else:
		if time_last > 0:
			countdown_accumulator += delta
			if countdown_accumulator >= 0.0125:
				time_last -= 1
				countdown_accumulator = 0.0
				set_time(time_last)
		else:
			time_last = 0
			erro_sfx.play()
			#vibrar e fazer som


func set_time(value: float) -> void:
	
	if $TextureProgressBar:
		$TextureProgressBar.value = (value / 7200) * 10000
