extends Node


const VILLAGE = preload("res://Levels/Village/village.tscn")

#MiniGames
const CATCH_THE_CAT = preload("res://Levels/MiniGames/CatchTheCat/catch_the_cat.tscn")
const FISHING = preload("res://Levels/MiniGames/Fishing/fishing.tscn")
const MOLE = preload("res://Levels/MiniGames/Mole/node_2d.tscn")
#Screens
const MAIN_MENU = preload("res://Levels/Screens/MainMenu/main_menu.tscn")
var village

#Game logic and consts
var current_minigame = null


func start_game() -> void:
	get_tree().change_scene_to_packed(VILLAGE)

func return_to_world() -> void:
	get_tree().change_scene_to_packed(VILLAGE)

func start_minigame(game_tag: String) -> void:
	match game_tag:
		"mole_game":
			get_tree().change_scene_to_packed(MOLE)
	
	
