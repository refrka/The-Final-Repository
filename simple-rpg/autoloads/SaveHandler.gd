extends Node


const SAVE_FOLDER = "user://saves"
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
	_validate_save_folder()



func _validate_save_folder() -> void:
	if !DirAccess.dir_exists_absolute(SAVE_FOLDER):
		DirAccess.make_dir_absolute(SAVE_FOLDER)
