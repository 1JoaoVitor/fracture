extends Control


var time_last: int = 7200
var pass_time: float = 0.0
var is_visible: bool = false
var is_counting: bool = false
var yellow_color = Color(1, 1, 0, 1)
var red_color = Color(1, 0, 0, 1)
var countdown_accumulator: float = 0.0
var progress: float
@onready var erro_sfx: AudioStreamPlayer = $Erro_sfx


func _ready() -> void:
	hide()
	set_timer()

func set_timer():
	
	if is_counting == false:
		is_counting = true

func action():
	
	time_last += 600
	if time_last > 7200:
		pass_time -= (time_last-7200)/120
		time_last = 7200
		is_visible = false
		hide()


func _process(delta: float) -> void:
	
	if is_counting:
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
					time_texture(time_last)
			else:
				time_last = 0
				erro_sfx.play()
				#vibrar e fazer som


func time_texture(value: float) -> void:
	if $TextureProgressBar:
		$TextureProgressBar.value = (value / 7200) * 10000
	if value < 5400 and value > 3600:
		progress = (float(value) - 3600)/ 1800
		if progress > 0.01:
			$TextureProgressBar.modulate = Color(0, 1, 0, 1).lerp(yellow_color, 1.0 - progress)
		else:
			$TextureProgressBar.modulate = Color(0, 1, 0, 1).lerp(yellow_color, 1.0)
	if value < 3600:
		progress = (float(value) - 1800)/ 1800
		if progress > 0.01:
			$TextureProgressBar.modulate = yellow_color.lerp(red_color, 1.0 - progress)
		else:
			$TextureProgressBar.modulate = yellow_color.lerp(red_color, 1.0)
