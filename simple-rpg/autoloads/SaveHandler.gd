extends Node


const SAVE_FOLDER = "user://saves/"
var date_mix = [
"1973-02-11:42:18",
"1995-08-23:77:64",
"2001-01-15:33:12",
"1980-12-30:88:51",
"1967-04-09:29:73",
"1999-06-17:54:40",
"2010-11-05:12:95",
"1978-09-02:68:44",
"1984-03-19:71:37",
"2007-07-25:83:09",
"1992-10-14:25:66",
"1963-05-28:39:14",
"1989-08-01:93:77",
"1971-01-07:16:88",
"2003-04-11:44:22",
"1997-12-03:85:58",
"1969-06-21:10:72",
"2015-09-09:27:34",
"1986-11-29:62:49",
"2008-02-13:19:81",
]


var current_save = {
	"name": "",
	"save_id": -1,
}












func _ready() -> void:
	Signals.GAME_exit.connect(_exit_save)
	_validate_save_folder()



func _validate_save_folder() -> void:
	if !DirAccess.dir_exists_absolute(SAVE_FOLDER):
		DirAccess.make_dir_absolute(SAVE_FOLDER)


func _exit_save() -> void:
	var character = CharacterHandler.get_character()
	if character != null:
		save(character)
		CharacterHandler.unload_character(character)



func generate_save_id() -> int:
	randomize()
	var i = randi_range(0, 19)
	var random_int = Time.get_unix_time_from_datetime_string(date_mix.get(i))
	var now_int = Time.get_unix_time_from_system()
	var id = abs(random_int - now_int)
	return id



func is_id_taken(new_id: int) -> bool:
	var is_taken:= false
	for file_name in DirAccess.open(SAVE_FOLDER).get_files():
		var id = file_name.trim_suffix(".json")
		if new_id == int(id):
			is_taken = true
	return is_taken



func is_name_taken(new_name: String) -> bool:
	var is_taken:= false
	var saves = get_all_saves()
	for data in saves:
		if data["character"]["name"] == new_name:
			is_taken = true
	return is_taken



func save(character: Character) -> void:
	var data = Data.collect_save_data(character)
	var file = FileAccess.open(SAVE_FOLDER + str(character.id) + ".json", FileAccess.WRITE)
	file.store_string(JSON.stringify(data, " "))
	file.close()
	Signals.SAVE_created.emit()
	PromptHandler.notice("Character saved: [b]%s[/b]" % character.name)



func load(id: int) -> void:
	var path = SAVE_FOLDER + str(id) + ".json"
	if !FileAccess.file_exists(path):
		print("Invalid save file id")
		return
	var json = JSON.new()
	var file = FileAccess.open(path, FileAccess.READ)
	json.parse(file.get_as_text())
	file.close()
	Data.load_save_data(json.data)
	



func delete(id: int) -> void:
	var path = SAVE_FOLDER + str(id) + ".json"
	if !FileAccess.file_exists(path):
		return
	var data = get_save_data_from_id(id)
	DirAccess.remove_absolute(path)
	Signals.SAVE_deleted.emit()
	PromptHandler.notice("Character deleted: [b]%s[/b]" % data["character"]["name"])




func get_all_saves() -> Array:
	var saves = []
	for file_name in DirAccess.open(SAVE_FOLDER).get_files():
		var file = FileAccess.open(SAVE_FOLDER + file_name, FileAccess.READ)
		var json = JSON.new()
		json.parse(file.get_as_text())
		file.close()
		saves.append(json.data)
	return saves



func get_save_data_from_id(id: int) -> Dictionary:
	var path = SAVE_FOLDER + str(id) + ".json"
	var file = FileAccess.open(path, FileAccess.READ)
	var json = JSON.new()
	json.parse(file.get_as_text())
	file.close()
	return json.data



func get_save_data_from_name(_name: String) -> Dictionary:
	var data = {}
	var all_saves = get_all_saves()
	for _save in all_saves:
		if _save["character"]["name"] == _name:
			data = _save
	return data
