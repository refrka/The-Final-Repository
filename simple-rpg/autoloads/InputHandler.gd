extends Node


func _unhandled_key_input(input: InputEvent) -> void:
	if input.is_action_pressed("escape"):
		Signals.GAME_escape.emit()