class_name Equipment extends Item



func _init(_key: Enums.EQUIPMENT) -> void:
	super(_key)
	type = Enums.ITEM_TYPE.EQUIPMENT
	data = Data.get_equipment_data(key)
	value = int(data["value"])