extends Control


var save_row = preload("res://scenes/rows/overlay_save_row.tscn")


func _ready() -> void:
	%NameEntry.keep_editing_on_text_submit = true
	Signals.SAVE_created.connect(_refresh_save_list)
	Signals.SAVE_deleted.connect(_refresh_save_list)
	load_save_list()


	%NameEntry.text_changed.connect(_check_name)
	%NameEntry.text_submitted.connect(_submit_name)
	%CreateCharacterButton.pressed.connect(_button_submit)
	%CreateCharacterButton.disabled = true


	%Test.pressed.connect(_test)



func _test() -> void:
	PromptHandler.notice("This is a notice")




func _refresh_save_list() -> void:
	for child in %CharacterList.get_children():
		child.queue_free.call_deferred()
	load_save_list()



func load_save_list() -> void:
	%NoSaves.visible = false
	var saves = SaveHandler.get_all_saves()
	if saves.size() == 0:
		%NoSaves.visible = true
		return
	saves.sort_custom(Data.sort_character_name)
	for save in saves:
		var row = save_row.instantiate()
		row.setup(save["character"])
		%CharacterList.add_child(row)



func _button_submit() -> void:
	_submit_name(%NameEntry.text)



func _submit_name(_name: String) -> void:
	var character = CharacterHandler.create_new_character(_name)
	SaveHandler.save(character)
	%NameEntry.clear()



func _check_name(_name: String) -> void:
	%CreateCharacterButton.disabled = true
	if _name.length() < 3:
		%CreateCharacterButton.text = "Too short"
	elif SaveHandler.is_name_taken(_name):
		%CreateCharacterButton.text = "Unavailable"
	else:
		%CreateCharacterButton.disabled = false
		%CreateCharacterButton.text = "Submit"
