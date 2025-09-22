extends Node

var charc: Character


func _ready() -> void:
	Signals.GAME_exit.connect(_load_main_overlay)
	Signals.GAME_quit.connect(_quit)
	Signals.CHARACTER_loaded.connect(_start_game)

	_load_main_overlay()



func _change_to_scene(_name: String) -> void:
	_hide_scenes()
	var scene = get_tree().get_first_node_in_group(_name)
	scene.visible = true



func _hide_scenes() -> void:
	var root = get_tree().get_first_node_in_group("control_root")
	for child in root.get_children():
		child.visible = false


func _start_game(character: Character) -> void:
	_change_to_scene("main_game")
	PromptHandler.notice("Character loaded: [b]%s[/b]" % character.name)


func _load_main_overlay() -> void:
	_hide_scenes()
	_change_to_scene("overlay")



func _quit() -> void:
	get_tree().quit()