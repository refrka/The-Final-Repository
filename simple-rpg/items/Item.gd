@abstract
class_name Item extends Object



var key: Variant
var type: Enums.ITEM_TYPE
var data: Dictionary
var value: int

func _init(_key: Variant) -> void:
	key = _key