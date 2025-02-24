extends Control
class_name CardUI

#codigo para ligar os estados da maquina de estados, conectando sinais

signal reparent_requested(which_card_ui: CardUI)

@export_group ("Card Atributtes")
@export var id: String
@export_enum("Soldado", "General", "Lider") var type: String
@export_enum("Alto", "Medio", "Baixo") var rank: String
@export_enum("Jade", "Safira", "Dourado", "Rubi", "Quartzo") var type_color: String

static var scene: PackedScene = preload("res://Interface/Cards/card_ui.tscn")
@onready var color: ColorRect = $Color
@onready var state: Label = $State
@onready var card_state_machine: CardStateMachine = $CardStateMachine as CardStateMachine
@onready var drop_point_detector: Area2D = $DropPointDetector
@onready var targets: Array[Node] = []
@onready var collision_shape : CollisionShape2D = $DropPointDetector/CollisionShape2D
@onready var border: TextureRect = $Border
@onready var power: Label = $Power
var mana_cost
@onready var face_front: TextureRect = $FaceFront

@export var FaceUpArt: CompressedTexture2D 
@export var FaceDownArt: CompressedTexture2D

@export var jade_border: Texture  
@export var rubi_border: Texture 
@export var dourado_border: Texture 
@export var safira_border: Texture  
@export var quartzo_border: Texture  
 
#imagens
var DRONEZINHO = preload("res://Imagens/Cards/Dronezinho.png")
var URSO_VIRIDIANO = preload("res://Imagens/Cards/urso_viridiano.jpg")
var ROBO_OPHIDIANO = preload("res://Imagens/Cards/robo_ophidiano.png")
var RATO_PARASITADO = preload("res://Imagens/Cards/RatoParasitado.png")

var is_face_up = false
var parent_slot: Node = null

static func new_card() -> CardUI:
	var card = scene.instantiate() as CardUI
	return card

func update_border() -> void:
	match self.type_color:
		"Jade":
			set_border(jade_border)
		"Safira":
			set_border(safira_border)
		"Dourado":
			set_border(dourado_border)
		"Rubi":
			set_border(rubi_border)
		"Quartzo":
			set_border(quartzo_border)
		
func update_value_color() -> void:
	match self.type_color:
		"Jade":
			self.power.set("theme_override_colors/font_color", Color("#68b968"))
		"Safira":
			self.power.set("theme_override_colors/font_color", Color("#82abe7"))
		"Dourado":
			self.power.set("theme_override_colors/font_color", Color("#efc16b"))
		"Rubi":
			self.power.set("theme_override_colors/font_color", Color("#e64942"))
		"Quartzo":
			self.power.set("theme_override_colors/font_color", Color("#dedede"))

func set_border(border_texture: Texture) -> void:
	border.texture = border_texture

func set_face_card(value: bool):
	if is_face_up == value:
		return
	is_face_up = value
	if is_face_up:
		self.get_node("AnimationPlayer").play("card_flip")
	else:
		self.get_node("AnimationPlayer").play("card_discard")
		
func update_art():
	var new_texture
	match self.type:
		"Soldado":
			match self.rank:
				"Alto":
					new_texture = ROBO_OPHIDIANO
				"Medio":
					new_texture = DRONEZINHO
				"Baixo":
					new_texture = RATO_PARASITADO
		"General":
			new_texture = URSO_VIRIDIANO
		
	if new_texture != null:
		self.face_front.texture = new_texture
		
func _ready() -> void:
	card_state_machine.init(self)
	update_border()
	update_value_color()
	update_art()
	
func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)

func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)
	
func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()
	
func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()

func _on_drop_point_detector_area_entered(area: Area2D) -> void:
	if not targets.has(area):
		targets.append(area)
	
func _on_drop_point_detector_area_exited(area: Area2D) -> void:
	targets.erase(area)


func move_to_position(pos: Vector2):
	var size = self.get_size()
	pos.x -= size.x / 2
	pos.y -= round(size.y / 2)
	pos.y = round(pos.y)
	var tween = get_tree().create_tween()
	tween.tween_property(
		self,  # O nó da carta
		"position",  # A propriedade a ser animada
		pos,  # A posição de destino (local dentro do conjunto de slots)
		0.5  # Duração da animação
	)
