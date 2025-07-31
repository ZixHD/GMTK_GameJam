extends Node2D

func _ready() -> void:
	$CanvasModulate.connect("time_tick", Callable(self, "_on_time_tick"))

func _on_time_tick(hour: int, minute: int) -> void:
	var display_hour = (hour + GameManager.START_TIME_HOUR) % 24
	$Timelabel.text = "%02d:%02d" % [display_hour, minute]
