extends Control

@onready var settings: Control = $Settings
@onready var buttons: VBoxContainer = $Buttons

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	settings.visible = false;


func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_options_pressed() -> void:
	settings.visible = true;
	buttons.visible = false;
	


func _on_resume_2_pressed() -> void:
	settings.visible = false;
	buttons.visible = true;


func _on_start_pressed() -> void:
	animation_player.play("fade")
	await animation_player.animation_finished
	await queue_free()
	SceneManager._start_game()
