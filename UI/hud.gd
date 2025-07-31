extends CanvasLayer

@onready var v_box_container: HBoxContainer = $VBoxContainer

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		print("opvde")
		var tex_rect = TextureRect.new()
		var texture = load("res://icon.svg")
		tex_rect.texture = texture
		tex_rect.stretch_mode = TextureRect.STRETCH_SCALE
		v_box_container.add_child(tex_rect)
