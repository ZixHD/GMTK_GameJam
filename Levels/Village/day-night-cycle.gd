extends CanvasModulate

const minutes_per_day = 1440
const minutes_per_hour = 60

var ingame_to_real_minute_duration: float   

signal time_tick(hour:int, minute:int)  

@export var gradient: GradientTexture1D

var time: float = 0.0
var past_minute: float = -1.0

func _ready() -> void:
	ingame_to_real_minute_duration = GameManager.REAL_SECONDS_PER_DAY / float(minutes_per_day)

func _process(delta: float) -> void:
	time += delta

	# progress through the day (0–1)
	var day_progress = fmod(time, GameManager.REAL_SECONDS_PER_DAY) / GameManager.REAL_SECONDS_PER_DAY

	# ✅ SHIFT start time using GameManager constants
	var offset = (GameManager.START_TIME_HOUR * 60 + GameManager.START_TIME_MINUTE) / 1440.0
	day_progress = fmod(day_progress + offset, 1.0)

	# update gradient (day/night colors)
	var value = (sin(day_progress * PI * 2 - PI/2) + 1.0) / 2.0
	self.color = gradient.gradient.sample(value)

	_recalculate_time()

func _recalculate_time() -> void:
	var total_minutes: float = time / ingame_to_real_minute_duration

	var displayed_minute: int = int(total_minutes) % minutes_per_day
	var hour = int(displayed_minute / minutes_per_hour)     # ✅ cleaner integer division
	var minute = displayed_minute % minutes_per_hour

	if past_minute != minute:
		past_minute = minute
		time_tick.emit(hour, minute)
