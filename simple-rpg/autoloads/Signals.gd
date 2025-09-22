extends Node
@warning_ignore_start("unused_signal")





signal GAME_escape
signal GAME_exit
signal GAME_quit
signal GAME_paused
signal GAME_unpaused







signal SAVE_created
signal SAVE_deleted





signal CHARACTER_loaded(character: Character)
signal CHARACTER_unloaded(character: Character)
signal CHARACTER_day_ended(day: int)
signal CHARACTER_entered_location(key: Enums.LOCATION)





signal INVENTORY_item_obtained(item: Item)
signal INVENTORY_item_removed(item: Item)