extends HBoxContainer


var save_id: int


func setup(data: Dictionary) -> void:
	save_id = data["id"]
	%Name.text = data["name"]
	%DeleteButton.pressed.connect(_delete.bind(data))
	%LoadButton.pressed.connect(_load.bind(data))



func _delete(data: Dictionary) -> void:
	SaveHandler.delete(data["id"])


func _load(data: Dictionary) -> void:
	SaveHandler.load(data["id"])