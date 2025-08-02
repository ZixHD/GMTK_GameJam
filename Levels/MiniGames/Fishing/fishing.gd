extends Node

@onready var player: CharacterBody2D = $Player
@onready var reel: Sprite2D = $Reel
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar


func _ready() -> void:
	player.connect("update_progress", Callable(self, "_on_player_update_progress"))
	player.connect("reeled", Callable(self, "_on_player_reeled"))
	texture_progress_bar.value = 1
	
func _on_player_update_progress(value):
	texture_progress_bar.value = value
	if texture_progress_bar.value >= 100:
		get_tree().paused = true
		print("win")
	
func _on_player_reeled():
	
	reel.rotate(.5)
