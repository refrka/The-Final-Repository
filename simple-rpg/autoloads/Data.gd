extends Node




var data_sets = {
	"location_data": "res://data/world/location_data.gd",
	
	"consumable_data": "res://data/items/consumable_data.gd",
	"equipment_data": "res://data/items/equipment_data.gd",
}





func collect_save_data(character: Character) -> Dictionary:
	var save_data = {}
	save_data["character"] = CharacterHandler.get_save_data(character)
	save_data["locations"] = LocationHandler.get_save_data()
	save_data["items"] = Inventory.get_save_data()
	return save_data



func load_save_data(data: Dictionary) -> void:
	Inventory.load_saved_items(data["items"])
	LocationHandler.load_saved_locations(data["locations"])
	CharacterHandler.load_saved_character(data["character"])



func sort_character_name(a, b) -> bool:
	if a["character"]["name"] < b["character"]["name"]:
		return true
	else:
		return false



func get_data_set(data_set_name: String) -> Dictionary:
	return load(data_sets[data_set_name]).new().data



func get_location_data(key: Enums.LOCATION) -> Dictionary:
	var data_set = load(data_sets["location_data"]).new().data
	return data_set[key]



func get_item_data(type: Enums.ITEM_TYPE, key: Variant) -> Dictionary:
	var data = {}
	match type:
		Enums.ITEM_TYPE.CONSUMABLE:
			data = get_consumable_data(key)
		Enums.ITEM_TYPE.EQUIPMENT:
			data = get_equipment_data(key)
	return data



func get_consumable_data(key: Enums.CONSUMABLE) -> Dictionary:
	var data_set = load(data_sets["consumable_data"]).new().data
	return data_set[key]



func get_equipment_data(key: Enums.EQUIPMENT) -> Dictionary:
	var data_set = load(data_sets["equipment_data"]).new().data
	return data_set[key]


