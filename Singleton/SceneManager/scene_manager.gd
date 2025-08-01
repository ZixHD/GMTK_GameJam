extends Node


const VILLAGE = preload("res://Levels/Village/village.tscn")

#MiniGames
const CATCH_THE_CAT = preload("res://Levels/MiniGames/CatchTheCat/catch_the_cat.tscn")
const FISHING = preload("res://Levels/MiniGames/Fishing/fishing.tscn")
const MOLE = preload("res://Levels/MiniGames/Mole/mole.tscn")

#Screens
const MAIN_MENU = preload("res://Levels/Screens/MainMenu/main_menu.tscn")


#Game logic and consts



func start_game() -> void:
	var village = VILLAGE.instantiate()
	add_child(village)
	
