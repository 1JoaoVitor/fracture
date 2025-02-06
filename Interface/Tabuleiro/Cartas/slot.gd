extends Node2D

var cards : Array[Card]
var card_slot = CardSlotSystem.new(self)

func get_card_target_position():
	return self.global_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
