extends Node2D

var is_scaling_down = false  # Variável para controlar o estado de escalonamento
var is_scaling_up = false
var state_mana: int = 0
var possition_mana: int = 0
var qtd_sup: int = 3
var qtd_inf: int = 3
@onready var mana_sfx: AudioStreamPlayer = $"../Mana_sfx"
@onready var erro_sfx: AudioStreamPlayer = $"../Erro_sfx"

func _ready():
	state_mana = Estado.get_state()
	possition_mana = Estado.get_position()
	if state_mana == 2:
		scale.x = 0.5 * scale.x
		scale.y = 0.5 * scale.y
	print("recebi essa porra:",state_mana)


#X gasta uma mana e Z gasta 2
func _input(event: InputEvent):
	
	if Input.is_action_just_pressed("X"):
		print("vatafa")
		if qtd_sup > 0 && possition_mana <4:
			qtd_sup -=1
			if state_mana == 1:
				mana_sfx.play()
				state_mana = 0
				is_scaling_up = false
				is_scaling_down = true
			elif possition_mana == qtd_sup:
				state_mana = 1
				is_scaling_up = true
		elif possition_mana <4:
			erro_sfx.play()
			print("pouca mana neh parceiro")
			
	if Input.is_action_just_pressed("Z"):
		if qtd_sup > 1 && possition_mana <4:
			qtd_sup -=2
			if possition_mana == qtd_sup+1 || possition_mana == qtd_sup+2:
				state_mana = 0
				is_scaling_up = false
				is_scaling_down = true
			elif possition_mana == qtd_sup:
				state_mana = 1
				is_scaling_up = true
		elif possition_mana <4:
			erro_sfx.play()
			print("pouca mana neh parceiro")
			
	if Input.is_action_just_pressed("R"):
		qtd_sup = 3
		if possition_mana == 3:
			state_mana = 1
			scale.x = 0.265
			scale.y = 0.272
		elif possition_mana <3:
			state_mana = 2
			scale.x = 0.1325
			scale.y = 0.136
		visible = true
		
		
	if Input.is_action_just_pressed("S"):
		if qtd_inf > 0 && possition_mana > 3:
			qtd_inf -=1
			if state_mana == 1:
				mana_sfx.play()
				state_mana = 0
				is_scaling_down = true
			elif possition_mana == qtd_inf+3:
				state_mana = 1
				is_scaling_up = true
		elif possition_mana > 3:
			erro_sfx.play()
			print("pouca mana neh parceiro")
			
	if Input.is_action_just_pressed("A"):
		print("recebi essa porra:",state_mana," ",possition_mana," ",qtd_sup,qtd_inf)
		if qtd_inf > 1 && possition_mana > 3:
			qtd_inf -=2
			mana_sfx.play()
			if possition_mana == qtd_inf+4 || possition_mana == qtd_inf+5:
				state_mana = 0
				is_scaling_down = true
			elif possition_mana == qtd_inf+3:
				state_mana = 1
				is_scaling_up = true
		elif possition_mana > 3:
			erro_sfx.play()
			print("pouca mana neh parceiro")
			
	if Input.is_action_just_pressed("E"):
		qtd_inf = 3
		if possition_mana == 6:
			state_mana = 1
			scale.x = 0.265
			scale.y = 0.272
		elif possition_mana > 3:
			state_mana = 2
			scale.x = 0.1325
			scale.y = 0.136
		visible = true


func _process(delta):
	
	if is_scaling_down:
		if scale.x > 0.05 and scale.y > 0.05:
			scale.x -= 0.2 * delta
			scale.y -= 0.2 * delta
		else:
			is_scaling_down = false
			visible = false
			
	if is_scaling_up:
		if scale.x < 0.265 and scale.y < 0.272:
			scale.x += 0.2 * delta
			scale.y += 0.2 * delta
		else:
			is_scaling_up = false
