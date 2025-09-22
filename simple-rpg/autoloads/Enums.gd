extends Node



const LOCATION = worldEnums.Location
const LOCATION_TAG = worldEnums.LocationTag


const ITEM_TYPE = itemEnums.ItemType
const ITEM_TAG = itemEnums.ItemTag
const CONSUMABLE = itemEnums.Consumable
const EQUIPMENT = itemEnums.Equipment


const ENTITY = entityEnums.Entity
const ENTITY_TAG = entityEnums.Entity


var enum_lists = {

	"location": LOCATION,
	"location_Tag": LOCATION_TAG,

	"item_type": ITEM_TYPE,
	"item_tag": ITEM_TAG,
	"consumable": CONSUMABLE,
	"equipment": EQUIPMENT,

	"entity": ENTITY,
	"entity_tag": ENTITY_TAG,

}




func get_enums(enum_list: String) -> Dictionary:
	var data = {}
	for enum_name in enum_lists[enum_list]:
		if enum_name != "NULL":
			var enum_value = enum_lists[enum_list][enum_name]
			data[enum_value] = enum_name
	return data