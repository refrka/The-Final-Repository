extends Node


var location_registry: Array




func _ready() -> void:
	Signals.CHARACTER_unloaded.connect(_clear_registry)





func get_or_register_location(key: Enums.LOCATION) -> Location:
	var location: Location
	if is_location_discovered(key):
		location = get_registered_location(key)
	else:
		location = new_location(key)
	return location



func is_location_discovered(key: Enums.LOCATION) -> bool:
	var is_discovered = false
	for location in location_registry:
		if location.key == key:
			is_discovered = true
	return is_discovered



func get_registered_location(key: Enums.LOCATION) -> Location:
	var location: Location
	for registered_location in location_registry:
		if registered_location.key == key:
			location = registered_location
	return location



func get_current_location() -> Enums.LOCATION:
	var character = CharacterHandler.get_character()
	return character.current_location



func new_location(key: Enums.LOCATION) -> Location:
	var location = Location.new(key)
	_register_location(location)
	PromptHandler.notice("Location discovered: [b]%s[/b]" % location.data["name"])
	return location






func get_save_data() -> Dictionary:
	var data = {}
	for location in location_registry:
		data[location.key] = { }
	return data



func load_saved_locations(data: Dictionary) -> void:
	for key in data:
		key = int(key)
		var location = Location.new(key)
		location_registry.append(location)




func _register_location(location: Location) -> void:
	if !location_registry.has(location):
		location_registry.append(location)



func _clear_registry(_character: Character) -> void:
	location_registry.clear()