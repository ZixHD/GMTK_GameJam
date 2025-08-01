extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var intro: Control = $"."


func _ready() -> void:
	animation_player.play("intro")
	

func hide_intro() -> void:
	intro.visible = false
