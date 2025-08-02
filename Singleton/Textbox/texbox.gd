extends MarginContainer

@onready var label: Label = $MarginContainer/Label
@onready var timer: Timer = $Timer


const MAX_WIDTH = 256

var text = ""
var letter_index = 0

var letter_timer = 0.03
var space_time = 0.06
var punctuation_time = 0.2

signal finished_displaying()

func display_text(text_to_display: String):

	text = text_to_display
	label.text = text_to_display
	
	
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y
		
	global_position.x -= size.x / 2
	global_position.y -= size.y  + 24
	
	label.text = text_to_display[0]
	_display_letter()
	
func _display_letter():
	
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		return
	else:
		label.text += text[letter_index]
		
	match text[letter_index]:
		
		"!", ".", ",", "?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			
			timer.start(letter_timer)
		

func _on_timer_timeout() -> void:
	_display_letter()
