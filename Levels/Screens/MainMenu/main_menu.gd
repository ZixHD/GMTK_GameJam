extends Control

@onready var settings: Control = $Settings
@onready var buttons: VBoxContainer = $Buttons



func _ready() -> void:
	settings.visible = false;






func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_options_pressed() -> void:
	settings.visible = true;
	buttons.visible = false;
	
