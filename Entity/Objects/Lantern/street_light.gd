extends StaticBody2D

func enable_light(state: bool) -> void:
	$PointLight2D.enabled = state
