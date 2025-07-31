extends StaticBody2D
@onready var sprite_2d: Sprite2D = $Sprite2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property(sprite_2d, "modulate:a", 0.5, 0.1)
	print("radi")


func _on_area_2d_body_exited(body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property(sprite_2d, "modulate:a", 1.0, 0.1)
