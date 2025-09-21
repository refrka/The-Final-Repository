extends Node


var active_character: Character = null


















func create_character(_name: String) -> Character:
	var character = Character.new(_name)
	return character



func load_character(character: Character) -> void:
	active_character = character
	Signals.CHARACTER_loaded.emit(character)



func unload_character(character: Character) -> void:
	active_character = null
	Signals.CHARACTER_unloaded.emit(character)



func save_character(character: Character) -> void:
	SaveHandler.save(character, character.new)



func is_character_loaded() -> bool:
	var is_loaded = true
	if active_character == null:
		is_loaded = false
	return is_loaded