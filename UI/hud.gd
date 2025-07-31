extends CanvasLayer

@onready var v_box_container: HBoxContainer = $VBoxContainer

func _ready() -> void:
	var tex_rect = TextureRect.new()
	var texture = load("res://icon.svg")
	tex_rect.texture = texture
	tex_rect.stretch_mode = TextureRect.EXPAND_KEEP_SIZE
	v_box_container.add_child(tex_rect)
	tex_rect = TextureRect.new()
	tex_rect.texture = texture
	tex_rect.stretch_mode = TextureRect.EXPAND_KEEP_SIZE
	v_box_container.add_child(tex_rect)
	v_box_container.add_child(tex_rect)
