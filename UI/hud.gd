extends CanvasLayer

@onready var v_box_container: HBoxContainer = $VBoxContainer


func add_item(texturePath: String):
	var tex_rect = TextureRect.new()
	tex_rect.texture = load(texturePath)
	tex_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH
	v_box_container.add_child(tex_rect)
