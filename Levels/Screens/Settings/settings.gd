extends Control

@onready var settings: Control = $"."
@onready var menu: VBoxContainer = $Menu
@onready var input_settings: Control = $InputSettings
@onready var check_box: CheckBox = $Menu/FullscreenBox/CheckBox

var fullscreen: bool = false;

func _on_controls_pressed() -> void:
	menu.visible = false
	input_settings.visible = true
	pass 


func _on_back_button_pressed() -> void:
	menu.visible = true
	input_settings.visible = false;
	pass


func _on_check_box_pressed() -> void:
	fullscreen = !fullscreen
	var param = null
	if fullscreen:
		param = DisplayServer.WINDOW_MODE_FULLSCREEN
	else:
		param = DisplayServer.WINDOW_MODE_WINDOWED
	DisplayServer.window_set_mode(param)


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_resume_pressed() -> void:
	Engine.time_scale = 1
	settings.visible = false;
