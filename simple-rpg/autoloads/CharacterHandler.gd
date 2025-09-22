extends Node


var active_character: Character = null






func update_property(property: String, new_value: Variant) -> void:
	active_character.set(property, new_value)



func create_new_character(_name: String) -> Character:
	var character = Character.new(_name)
	var valid_id = false
	var new_id: int
	while valid_id == false:
		new_id = SaveHandler.generate_save_id()
		if !SaveHandler.is_id_taken(new_id):
			valid_id = true
	character.id = new_id
	return character



func is_character_loaded() -> bool:
	var is_loaded = true
	if active_character == null:
		is_loaded = false
	return is_loaded






func create_character(_name: String) -> Character:
	var character = Character.new(_name)
	return character


func get_character() -> Character:
	return active_character


func load_character(character: Character) -> void:
	active_character = character
	add_child(active_character)
	Signals.CHARACTER_loaded.emit(character)



func unload_character(character: Character) -> void:
	remove_child(active_character)
	active_character = null
	Signals.CHARACTER_unloaded.emit(character)








func load_saved_character(data: Dictionary) -> void:
	var character = create_character(data["name"])
	character.id = data["id"]
	character.day = data["day"]
	load_character(character)



func get_save_data(character: Character) -> Dictionary:
	var data = {}
	data["name"] = character.name
	data["id"] = character.id
	data["day"] = character.day
	data["experience"] = character.experience
	data["level"] = character.level
	data["attack"] = character.attack
	data["current_health"] = character.current_health
	data["max_health"] = character.max_health
	return data










func enter_location(key: Enums.LOCATION) -> void:
	active_character.current_location = key
	if !LocationHandler.is_location_discovered(key):
		LocationHandler.new_location(key)
	Signals.CHARACTER_entered_location.emit(key)
	