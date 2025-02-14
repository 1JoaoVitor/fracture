extends Control
class_name CardUI

#codigo para ligar os estados da maquina de estados, conectando sinais

signal reparent_requested(which_card_ui: CardUI)

@export var card: Card

static var scene: PackedScene = preload("res://Interface/Cards/card_ui.tscn")
@onready var color: ColorRect = $Color
@onready var state: Label = $State
@onready var card_state_machine: CardStateMachine = $CardStateMachine as CardStateMachine
@onready var drop_point_detector: Area2D = $DropPointDetector
@onready var targets: Array[Node] = []
@onready var collision_shape : CollisionShape2D = $DropPointDetector/CollisionShape2D

@export var FaceUpArt: CompressedTexture2D 
@export var FaceDownArt: CompressedTexture2D

@onready var texture_rect: TextureRect = $ArteCarta
 

var is_face_up = false
var card_type
var parent_slot: Node = null

static func new_card() -> CardUI:
	var card = scene.instantiate() as CardUI
	return card


func set_face_card(value: bool):
	is_face_up = value
	if not is_inside_tree():
		await ready
	if(is_face_up):
		self.get_node("AnimationPlayer").play("card_flip")
	else:
		self.get_node("AnimationPlayer").play("card_discard")


func _ready() -> void:
	card_state_machine.init(self)
	
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
