extends Control



func _ready() -> void:
	Signals.CHARACTER_loaded.connect(_load_character)
	Signals.CHARACTER_entered_location.connect(_update_location)
	%EndDayButton.pressed.connect(_end_day)


	%AddConsumable.pressed.connect(Inventory.create_and_add_item.bind(Enums.ITEM_TYPE.CONSUMABLE, 1))
	%AddEquipment.pressed.connect(Inventory.create_and_add_item.bind(Enums.ITEM_TYPE.EQUIPMENT, 1))


func _load_character(character: Character) -> void:
	%CharacterName.text = character.name
	_update_day()
	print(LocationHandler.location_registry)
	_load_locations()



func _update_day() -> void:
	var character = CharacterHandler.get_character()
	%Day.text = str(character.day)



func _update_location(key: Enums.LOCATION) -> void:
	var data = Data.get_location_data(key)
	%CurrentLocation.text = data["name"]
	_update_items(data)
	_update_entities()



func _update_items(data: Dictionary) -> void:
	for child in %ItemList.get_children():
		child.queue_free.call_deferred()
	for item_type in data["items"]:
		for item_key in data["items"][item_type]:
			var item_data = Data.get_item_data(item_type, item_key)
			var button = Button.new()
			button.text = item_data["name"]
			%ItemList.add_child(button)




func _update_entities() -> void:
	for child in %EntityList.get_children():
		child.queue_free.call_deferred()




func _end_day() -> void:
	var character = CharacterHandler.get_character()
	var day = character.day
	CharacterHandler.update_property("day", day+1)
	_update_day()


func _load_locations() -> void:
	_clear_location_list()
	var location_enums = Enums.get_enums("location")
	for key in location_enums:
		var data = Data.get_location_data(key)
		var button = Button.new()
		if LocationHandler.is_location_discovered(key):
			button.text = data["name"]
		else:
			button.text = "Undiscovered"
		button.pressed.connect(_select_location.bind(button, key))
		%AllLocations.add_child(button)




func _select_location(button: Button, key: Enums.LOCATION) -> void:
	var data = Data.get_location_data(key)
	if !LocationHandler.is_location_discovered(key):
		button.text = data["name"]
	CharacterHandler.enter_location(key)



func _clear_location_list() -> void:
	for child in %AllLocations.get_children():
		child.queue_free.call_deferred()