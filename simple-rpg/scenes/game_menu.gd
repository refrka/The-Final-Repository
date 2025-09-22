extends Control


func _ready() -> void:
	visible = false
	Signals.GAME_escape.connect(_toggle)
	%SaveButton.pressed.connect(_save)
	%ExitButton.pressed.connect(_exit)

	



func _toggle() -> void:
	visible = !visible
	if visible == true:
		%SaveButton.disabled = false
		Signals.GAME_paused.emit()
		var character = CharacterHandler.get_character()
		if character == null:
			%SaveButton.disabled = true
	else:
		Signals.GAME_unpaused.emit()
		




func _save() -> void:
	var character = CharacterHandler.get_character()
	if character != null:
		_toggle()
		SaveHandler.save(character)





func _exit() -> void:
	var character = CharacterHandler.get_character()
	if character != null:
		Signals.GAME_exit.emit()
		_toggle()
	else:
		Signals.GAME_quit.emit()