extends Area2D
class_name InteractionArea

var interact: Callable = func():
	var new_scene = load("res://Levels/MiniGames/Mole/node_2d.tscn")
	get_tree().change_scene_to_packed(new_scene)
	pass

func _on_body_entered(_body: Node2D) -> void:
	print("radi")
	InteractionManager.register_area(self)
	pass # Replace with function body.


func _on_body_exited(_body: Node2D) -> void:
	InteractionManager.unregister_area(self)
	pass # Replace with function body.
