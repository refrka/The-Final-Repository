class_name Consumable extends Item



func _init(_key: Enums.CONSUMABLE) -> void:
	super(_key)
	type = Enums.ITEM_TYPE.CONSUMABLE
	data = Data.get_consumable_data(key)
	value = int(data["value"])