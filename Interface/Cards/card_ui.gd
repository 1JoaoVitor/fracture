extends Control
class_name CardUI

signal reparent_requested(which_card_ui: CardUI)

@onready var color_rect: ColorRect = $ColorRect
@onready var state: Label = $State
