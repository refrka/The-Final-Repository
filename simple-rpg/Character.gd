class_name Character extends Node


var id: int
var day: int = 1

var current_location: Enums.LOCATION

var level: int = 0
var experience: int = 0
var attack: float = 1.0
var current_health: int = 25
var max_health: int = 25









func _init(_name: String) -> void:
	name = _name