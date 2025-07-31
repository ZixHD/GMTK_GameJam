extends Node2D

@onready var timelabel: Label = $Timelabel

var lights_on = false;

func _ready() -> void:
	$CanvasModulate.connect("time_tick", Callable(self, "_on_time_tick"))

func _process(_delta: float) -> void:
	if timelabel.text == "17:00":
		$AnimationPlayer.play("Night_falling")
	elif timelabel.text == "03:00":
		$AnimationPlayer.play_backwards("Night_falling")

func _on_time_tick(hour: int, minute: int) -> void:
	var display_hour = (hour + GameManager.START_TIME_HOUR) % 24
	timelabel.text = "%02d:%02d" % [display_hour, minute]
	if timelabel.text == "19:00":
		lights_on = true;
		enable_lights(true)
	elif timelabel.text == "05:59":
		lights_on = false;
		enable_lights(false)

func enable_lights(state: bool) -> void:
	print($Lights.get_children())
	for staticbody2d in $Lights.get_children():
		staticbody2d.enable_light(state)
