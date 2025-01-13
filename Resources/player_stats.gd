extends SumValues
class_name PlayerStats

var max_mana_principal := 1
var max_mana_adicional := 2

var mana_adicional: int : set = set_mana_adicional
var mana_principal: int : set = set_mana_principal

func set_mana_adicional(value : int) -> void:
	mana_adicional = clampi(value, 0, max_mana_adicional) 
	sum_value_changed.emit()
	
func set_mana_principal(value : int) -> void:
	mana_principal = clampi(value, 0, max_mana_principal) 
	sum_value_changed.emit()
	
func reset_mana() -> void:
	self.mana_adicional = 2
	self.mana_principal = 1
	
func can_play_card(card: CardUI) -> void: #criar após a definição de qual carta é qual 
	pass
