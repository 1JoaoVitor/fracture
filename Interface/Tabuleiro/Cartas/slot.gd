extends Node2D

var cards : Array[Card]
var card_slot = CardSlotSystem.new(self)
@export var allowed_types: Array[String]  #Editable list in the editor for each slot

func can_place_card(card: CardUI) -> bool:
	return true #adicionar card.type para mudar o return
	#return card.card_type in allowed_types

func get_card_target_position(card_index: int, total_cards: int):
	var base_position = self.global_position  # Posição base do slot
	var offset_x = 60  # Distância entre cartas (ajuste conforme necessário)

	if total_cards == 1:
		return base_position  # Apenas uma carta, fica centralizada
	else:
		# Distribui as cartas horizontalmente ao redor do slot
		var start_x = base_position.x - ((total_cards - 1) * offset_x / 2)
		return Vector2(start_x + (card_index * offset_x), base_position.y)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
