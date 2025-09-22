extends Resource


var data = {


	Enums.LOCATION.NULL: {
		"": "",
	},


	Enums.LOCATION.CALIC_CITY: {
		"name": "Calic City",
		"tags": [
			Enums.LOCATION_TAG.CIVILIZED,
			Enums.LOCATION_TAG.REGION,
			Enums.LOCATION_TAG.URBAN,
		],
		"items": {
			Enums.ITEM_TYPE.CONSUMABLE: [
				Enums.CONSUMABLE.POTION_LIGHT_HEALING,
			]
		}
	},


	Enums.LOCATION.NORTHER_FOREST: {
		"name": "Northern Forest",
		"tags": [
			Enums.LOCATION_TAG.REGION,
			Enums.LOCATION_TAG.UNCIVILIZED,
			Enums.LOCATION_TAG.WILD,
		],
		"items": {
			Enums.ITEM_TYPE.CONSUMABLE: [
				Enums.CONSUMABLE.WILD_BERRIES,
			]
		}
	}


}