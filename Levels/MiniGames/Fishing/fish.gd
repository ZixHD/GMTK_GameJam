extends CharacterBody2D


@export var speed: int = 200
@export var maxTop: int = 100
@export var maxBottom: int = 600

var rng = RandomNumberGenerator.new()
var target: Vector2 = Vector2.ZERO

func _ready() -> void:
	target = position
	rng.randomize()
	update_target()
	
func _process(delta: float) -> void:
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 1:
		move_and_slide()
	else:
		update_target()
	
func update_target():
	print("pozc")
	var my_rng = rng.randf_range(maxTop, maxBottom)
	target.y = my_rng
