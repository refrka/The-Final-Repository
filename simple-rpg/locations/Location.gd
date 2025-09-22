class_name Location extends Object


var key: int
var data: Dictionary


func _init(_key: int) -> void:
	key = _key
	data = Data.get_location_data(key)