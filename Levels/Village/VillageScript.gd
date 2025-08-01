extends Node2D

@onready var canvas_modulate: CanvasModulate = $CanvasModulate
@onready var lights: Node2D = $Lights
@onready var settings: Control = $HUD/Settings
@onready var camera: Camera2D = $Player/Camera2D
@onready var marker_top: Marker2D = $Markers/MarkerTop
@onready var marker_bottom: Marker2D = $Markers/MarkerBottom
@onready var marker_left: Marker2D = $Markers/MarkerLeft
@onready var marker_right: Marker2D = $Markers/MarkerRight

var lights_on = false;
var time_label = null;
var game_paused = false;

func _ready() -> void:
	canvas_modulate.connect("time_tick", Callable(self, "_on_time_tick"))
	time_label = Hud.get_child(1);
	camera.limit_top = marker_top.global_position.y
	camera.limit_bottom = marker_bottom.global_position.y
	camera.limit_left = marker_left.global_position.x
	camera.limit_right = marker_right.global_position.x
	
func _process(_delta: float) -> void:
	pass

func _on_time_tick(hour: int, minute: int) -> void:
	
	var display_hour = (hour + GameManager.START_TIME_HOUR) % 24
	time_label.text = "%02d:%02d" % [display_hour, minute]
	if time_label.text == "19:00":
		lights_on = true;
		enable_lights(true)
	elif time_label.text == "05:59":
		lights_on = false;
		enable_lights(false)

func enable_lights(state: bool) -> void:
	for staticbody2d in lights.get_children():
		staticbody2d.enable_light(state)
		
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		Engine.time_scale = 0
		settings.visible = true;

		get_tree().root.get_viewport().set_input_as_handled()
