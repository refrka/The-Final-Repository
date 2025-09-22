extends Node



var item_list: Array



func _ready() -> void:
	Signals.CHARACTER_unloaded.connect(_clear_item_list)




func create_item(type: Enums.ITEM_TYPE, key: Variant) -> Item:
	var item: Item
	match type:
		Enums.ITEM_TYPE.CONSUMABLE:
			key = key as Enums.CONSUMABLE
			item = Consumable.new(key)
		Enums.ITEM_TYPE.EQUIPMENT:
			key = key as Enums.EQUIPMENT
			item = Equipment.new(key)
	return item


func create_and_add_item(type: Enums.ITEM_TYPE, key: Variant) -> void:
	var item = create_item(type, key)
	add_item(item)



func add_item(item: Item) -> void:
	item_list.append(item)
	Signals.INVENTORY_item_obtained.emit(item)



func remove_item(item: Item) -> void:
	item_list.erase(item)
	Signals.INVENTORY_item_removed.emit(item)



func get_save_data() -> Dictionary:
	var data = {}
	for item_type in Enums.get_enums("item_type"):
		data[item_type] = {}
		var items = get_items_of_type(item_type)
		for item in items:
			if data[item_type].has(item.key):
				data[item_type][item.key] += 1
			else:
				data[item_type][item.key] = 1
	return data



func load_saved_items(data: Dictionary) -> void:
	for item_type in data:
		for item_key in data[item_type]:
			for i in data[item_type][item_key]:
				var type = int(item_type) as Enums.ITEM_TYPE
				var key = int(item_key)
				var item = create_item(type, key)
				item_list.append(item)



func get_items_of_type(type: Enums.ITEM_TYPE) -> Array:
	var items = []
	for item in item_list:
		if item.type == type:
			items.append(item)
	return items





func _clear_item_list(_character: Character) -> void:
	item_list.clear()