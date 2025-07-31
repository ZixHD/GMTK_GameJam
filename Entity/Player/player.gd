extends CharacterBody2D


@export var speed: float = 150.0

var input: Vector2 = Vector2.ZERO
enum state {IDLE_RIGHT, IDLE_LEFT, IDLE_UP, IDLE_DOWN, WALK_RIGHT, WALK_LEFT, WALK_UP, WALK_DOWN, PAUSED}
var player_state = state.IDLE_LEFT


func _update_animation():
	pass
	#print("")

func _process(delta: float) -> void:
	movement(delta)
	


func movement(_delta:float) -> void:
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))

	if(Input.is_action_pressed("left")):
		player_state = state.WALK_LEFT
	if Input.is_action_pressed("right"):
		player_state = state.WALK_RIGHT
	if Input.is_action_pressed("down"):
		player_state = state.WALK_DOWN
	if Input.is_action_pressed("up"):
		player_state = state.WALK_UP
		
	
	input = input.normalized();
	velocity = input * speed
	move_and_slide()
	_update_animation()
	
