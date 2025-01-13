extends Resource
class_name SumValues

signal sum_value_changed

var actual_value: int : set = set_actual_value

func set_actual_value(value: int) -> void:
	sum_value_changed.emit()
	
func new_sum(new_value : int) -> void: #colocar separação de soma ou subtração aqui?
	self.actual_value += new_value
	
func create_instance() -> Resource:
	var instance: SumValues = self.duplicate()
	instance.actual_value = 0
	return instance
