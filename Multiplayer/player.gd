extends Node
class_name Player

var nickname: String
var id: int

func _init(nickname: String = '', id: int = 1):
	if id != 1:
		self.id = id
	if nickname != '':
		self.nickname = nickname

# Automatically serializes an instance into a dictionary
func to_dict() -> Dictionary:
	var result = {}
	for property in self.get_property_list():
		if property.usage & PROPERTY_USAGE_SCRIPT_VARIABLE:
			result[property.name] = get(property.name)
	return result

# Automatically deserializes a dictionary into an instance
static func from_dict(data: Dictionary) -> Player:
	var instance = Player.new()
	for key in data.keys():
		instance.set(key, data[key])
	
	return instance


func set_nickname(nickname: String):
	self.nickname = nickname
	var player_config_path = "user://player.ini"
	var player_config = ConfigFile.new()
	player_config.set_value("Player", "nickname", self.nickname)
	player_config.save(player_config_path)


func load_nickname():
	var player_config_path = "user://player.ini"
	var player_config = ConfigFile.new()
	var error := player_config.load(player_config_path)
	if error:
		return

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
