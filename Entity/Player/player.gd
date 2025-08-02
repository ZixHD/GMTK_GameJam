extends CharacterBody2D


@export var speed: float = 150.0
@onready var animation: AnimationPlayer = $AnimationPlayer


const lines: Array[String] = [
	"What a beutiful day!",
	"That must be Rex",
	"It's Sunday again?",
	"Maybe it was a dream",
	"No way!",
	"I must be cursed"
]
var input: Vector2 = Vector2.ZERO
enum state {IDLE_RIGHT, IDLE_LEFT, IDLE_UP, IDLE_DOWN, WALK_RIGHT, WALK_LEFT, WALK_UP, WALK_DOWN, PAUSED}
var player_state = state.IDLE_LEFT
var last_state_before_reading: state = state.IDLE_RIGHT;



func _update_animation():
	match(player_state):
		state.IDLE_RIGHT:
			animation.play("idel R")
		state.IDLE_LEFT:
			animation.play("idle L")
		state.IDLE_UP:
			animation.play("idle back")
		state.IDLE_DOWN:
			animation.play("idle")
		state.WALK_RIGHT:
			animation.play("walk R")
			player_state = state.IDLE_RIGHT
		state.WALK_LEFT:
			animation.play("walk L")
			player_state = state.IDLE_LEFT
		state.WALK_UP:
			animation.play("walk back")
			player_state = state.IDLE_UP
		state.WALK_DOWN:
			animation.play("walk front")
			player_state = state.IDLE_DOWN
		state.PAUSED:
			_readingAnimations(last_state_before_reading)
			velocity = Vector2.ZERO  
		
func _readingAnimations(last_state: state):

	match(last_state):
		state.IDLE_RIGHT:
			animation.play("idle right")
		state.IDLE_LEFT:
			animation.play("idle left")
		state.IDLE_UP:
			animation.play("idle back")
		state.IDLE_DOWN:
			animation.play("idle front")
		state.WALK_RIGHT:
			animation.play("idle right")
		state.WALK_LEFT:
			animation.play("idle left")
		state.WALK_UP:
			animation.play("idle back")
		state.WALK_DOWN:
			animation.play("idle front")
		


func _process(delta: float) -> void:
	if(player_state != state.PAUSED and Engine.time_scale == 1):
		movement(delta)

	


func movement(_delta:float) -> void:
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))

	if(Input.is_action_pressed("move_left")):
		player_state = state.WALK_LEFT
	if Input.is_action_pressed("move_right"):
		player_state = state.WALK_RIGHT
	if Input.is_action_pressed("move_down"):
		player_state = state.WALK_DOWN
	if Input.is_action_pressed("move_up"):
		player_state = state.WALK_UP
		
	
	input = input.normalized();
	velocity = input * speed
	move_and_slide()
	_update_animation()
	

func _on_pause_started():
	last_state_before_reading = player_state
	player_state = state.PAUSED 
	_update_animation()

func _on_pause_finished():
	player_state = last_state_before_reading;
	
func _on_spawn(position: Vector2, direction: String):
	global_position = position
	match(direction):
		"up":
			player_state = state.IDLE_UP
		"down":
			player_state = state.IDLE_DOWN
		"left":
			player_state = state.IDLE_LEFT
		"right":
			player_state = state.IDLE_RIGHT
