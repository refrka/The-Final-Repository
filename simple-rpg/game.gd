extends Node




func _ready() -> void:
	var string = "1988-07-27:66:77"
	var unix = Time.get_unix_time_from_datetime_string(string)
	
	var string2 = Time.get_datetime_string_from_system()
	var unix2 = Time.get_unix_time_from_datetime_string(string2)
	print(unix)
	print(unix2)