extends Node2D



var lights_on = false;
var time_label = null;

func _ready() -> void:
	$CanvasModulate.connect("time_tick", Callable(self, "_on_time_tick"))
	time_label = Hud.get_child(1);

func _process(_delta: float) -> void:
	pass

func _on_time_tick(hour: int, minute: int) -> void:
	
	var display_hour = (hour + GameManager.START_TIME_HOUR) % 24
	time_label.text = "%02d:%02d" % [display_hour, minute]
	if time_label.text == "14:00":
		lights_on = true;
		enable_lights(true)
	elif time_label.text == "05:59":
		lights_on = false;
		enable_lights(false)

func enable_lights(state: bool) -> void:
	print($Lights.get_children())
	for staticbody2d in $Lights.get_children():
		staticbody2d.enable_light(state)
