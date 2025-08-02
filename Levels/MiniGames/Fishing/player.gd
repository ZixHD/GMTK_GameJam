extends CharacterBody2D


const GRAVITY = 9.8
const FLAP = 300
const MAXFALLSPEED = 400
const UP = Vector2.UP

@export var scaleY = 1

var motion: Vector2 = Vector2.ZERO
var fish_inside = false
var percent_complete = 0

signal update_progress(value)
signal reeled

func _ready() -> void:
	scale.y = scaleY
	
func _process(delta: float) -> void:
	velocity.y += GRAVITY
	if velocity.y > MAXFALLSPEED:
		velocity.y = MAXFALLSPEED
		
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = -FLAP
		emit_signal("reeled")
		
	move_and_slide()
	update_percent_completed()
	
func update_percent_completed():
	if fish_inside:
		percent_complete += 1
		if percent_complete > 100:
			percent_complete = 100
	else:
		percent_complete = 1
		if percent_complete < 0:
			percent_complete = 0
	emit_signal("update_progress", percent_complete)


func _on_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("Fish"):
		fish_inside = true


func _on_detect_body_exited(body: Node2D) -> void:
	if body.is_in_group("Fish"):
		fish_inside = false
