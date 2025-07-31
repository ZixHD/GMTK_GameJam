extends CanvasModulate

const minutes_per_day = 1440
const minutes_per_hour = 60
var real_seconds_per_day = GameManager.REAL_SECONDS_PER_DAY
var ingame_to_real_minute_duration: float


signal time_tick(day:int, hour:int, minute:int)

@export var gradient:GradientTexture1D

var time: float = 0.00
var past_minute:float = -1.0

func _process(delta: float) -> void:
	ingame_to_real_minute_duration = GameManager.REAL_SECONDS_PER_DAY / float(minutes_per_day)
	time += delta
	var day_progress = fmod(time, real_seconds_per_day) / real_seconds_per_day
	var value = (sin(day_progress * PI * 2 + PI / 2) + 1.0) / 2.0
	self.color = gradient.gradient.sample(value)
	
	_recalculate_time()

func _recalculate_time() -> void:
	var total_minutes = int(time / ingame_to_real_minute_duration)
	
	var day = int(total_minutes / minutes_per_day)
	
	var current_day_minutes = total_minutes % minutes_per_day
	
	var hour = int(current_day_minutes / minutes_per_hour)
	
	var minute = int(current_day_minutes % minutes_per_hour)
	
	if past_minute != minute:
		past_minute = minute
	
	time_tick.emit(day, hour, minute)
